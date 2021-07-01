//
//  DotaHeroesTests.swift
//  DotaHeroesTests
//
//  Created by Indra Permana on 29/06/21.
//

import XCTest
import RxSwift
import RxBlocking
@testable import DotaHeroes

class DotaHeroesTests: XCTestCase {
  
  var sut: HeroStatsInteractor!
  
  
  func testHeroStatsInteractor() throws {
    // Given: an interactor that use mock Repository
    let remote = RemoteDataSourceMock(
      remoteReturnValue: .just(HeroStatsResponsesMock().generateHeroStats()))
    let local = LocalDataSourceMock(
      heroesReturnValue: .just(HeroStatsEntityMock().generateHeroStats()),
      addHeroReturnValue: .just(true))
    let repo = HeroStatsRepository(remote: remote, local: local)
    
    sut = HeroStatsInteractor(repo: repo)
    
    // When: Interactor execute calling Repository
    let heroesCount = sut.getHeroStats(role: nil).map {$0.count}
    
    // Then: The Output Counts (Entity) should be equal as the Input (Responses)
    XCTAssertEqual(try heroesCount.toBlocking().first(), DotaHeroesTests.HeroStatsResponsesMock.heroStatsMockCount)
    
  }
  
  class RemoteDataSourceMock: RemoteDataSourceProtocol {
    
    var remoteReturnValue: Observable<[HeroStats]>
    
    public init (remoteReturnValue: Observable<[HeroStats]>) {
      self.remoteReturnValue = remoteReturnValue
    }
    
    func getHeroStats() -> Observable<[HeroStats]> {
      return remoteReturnValue
    }
    
  }
  
  class LocalDataSourceMock: LocalDataSourceProtocol {
    
    var heroesReturnValue: Observable<[HeroStatEntity]>
    var addHeroReturnValue: Observable<Bool>
    
    public init(heroesReturnValue: Observable<[HeroStatEntity]>, addHeroReturnValue: Observable<Bool>) {
      self.heroesReturnValue = heroesReturnValue
      self.addHeroReturnValue = addHeroReturnValue
    }
    
    func getHeroStats(role: String?) -> Observable<[HeroStatEntity]> {
      return heroesReturnValue
    }
    
    func addHeroStats(heroes: [HeroStatEntity]) -> Observable<Bool> {
      return addHeroReturnValue
    }
    
  }
  
  struct HeroStatsResponsesMock {
    static var heroStatsMockCount = 2
    
    func generateHeroStats() -> [HeroStats] {
      var heroStats: [HeroStats] = []
      
      for _ in 0..<HeroStatsResponsesMock.heroStatsMockCount {
        let heroStat = HeroStats(
          id: Int.random(in: 0...99),
          localized_name: "Hero",
          primary_attr: "agi",
          attack_type: "Melee",
          roles: [],
          base_health: 200,
          base_attack_max: 30,
          base_agi: 15,
          img: ""
        )
        heroStats.append(heroStat)
      }
      
      return heroStats
    }
    
  }
  
  struct HeroStatsEntityMock {
    
    func generateHeroStats() -> [HeroStatEntity] {
      var heroStats: [HeroStatEntity] = []
      
      for _ in 0..<HeroStatsResponsesMock.heroStatsMockCount {
        let hero = HeroStatEntity()
        heroStats.append(hero)
      }
      
      return heroStats
    }
  }
  
}
