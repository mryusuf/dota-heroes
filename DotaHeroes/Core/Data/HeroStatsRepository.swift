//
//  HeroStatsRepository.swift
//  DotaHeroes
//
//  Created by Indra Permana on 29/06/21.
//

import Foundation
import RxSwift

protocol HeroStatsRepositoryProtocol {
  
  func getHeroStats(role: String?) -> Observable<[HeroStatsModel]>
  func getSimilarHeroImgPaths(attribute: String) -> Observable<[String]>
  
}

final class HeroStatsRepository: NSObject {
  
  typealias HeroInstance = (RemoteDataSource, LocalDataSource) -> HeroStatsRepository
  
  fileprivate let remote: RemoteDataSourceProtocol
  fileprivate let local: LocalDataSourceProtocol
  
  public init(remote: RemoteDataSourceProtocol, local: LocalDataSourceProtocol) {
    self.remote = remote
    self.local = local
  }
  
  static let shared: HeroInstance = { remote, local in
    return HeroStatsRepository(remote: remote, local: local)
  }
  
}

extension HeroStatsRepository: HeroStatsRepositoryProtocol {
  
  func getHeroStats(role: String?) -> Observable<[HeroStatsModel]> {
    return self.local.getHeroStats(role: role)
      .map { Mapper.mapEntityToDomain(input: $0)}
      .filter { !$0.isEmpty }
      .ifEmpty(
        switchTo: self.remote.getHeroStats()
          .map { Mapper.mapResponsesToEntity(input: $0)}
          .flatMap { self.local.addHeroStats(heroes: $0)}
          .filter { $0 }
          .flatMap {_ in
            self.local.getHeroStats(role: role)
              .map { Mapper.mapEntityToDomain(input: $0)}
          }
      )
  }
  
  func getSimilarHeroImgPaths(attribute: String) -> Observable<[String]> {
    return self.local.getSimilarHeroImgPaths(attribute: attribute)
  }
}
