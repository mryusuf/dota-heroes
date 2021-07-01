//
//  Injection.swift
//  DotaHeroes
//
//  Created by Indra Permana on 30/06/21.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
  
  func provideRepository() -> HeroStatsRepositoryProtocol {
    
    let remote = RemoteDataSource.shared
    let realm = try? Realm()
    let local = LocalDataSource.shared(realm)
    
    return HeroStatsRepository.shared(remote, local)
  }
  
  func provideHeroStats() -> HeroStatsUseCase {
    let repository = provideRepository()
    return HeroStatsInteractor(repository: repository)
  }
  
  func provideHeroStatDetail(with hero: HeroStatsModel) -> HeroDetailUseCase {
    let repository = provideRepository()
    return HeroDetailInteractor(repository: repository, hero: hero)
  }
}
