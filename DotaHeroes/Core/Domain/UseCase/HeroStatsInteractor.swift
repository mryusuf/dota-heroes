//
//  HeroStatsInteractor.swift
//  DotaHeroes
//
//  Created by Indra Permana on 29/06/21.
//

import Foundation
import RxSwift

protocol HeroStatsUseCase {
  
  var presenter: HomePresenterProtocol? { get set }
  func getHeroStats(role: String?) -> Observable<[HeroStatsModel]>
  
}

class HeroStatsInteractor: HeroStatsUseCase {
  
  private let repository: HeroStatsRepositoryProtocol
  weak var presenter: HomePresenterProtocol?
  
  required init (repository: HeroStatsRepositoryProtocol) {
    self.repository = repository
  }
  
  func getHeroStats(role: String?) -> Observable<[HeroStatsModel]> {
    return repository.getHeroStats(role: role)
  }
}
