//
//  HeroDetailInteractor.swift
//  DotaHeroes
//
//  Created by Indra Permana on 30/06/21.
//

import Foundation
import RxSwift

protocol HeroDetailUseCase: AnyObject {
  
  var presenter: HeroDetailPresenterProtocol? { get set }
  func getHero() -> HeroStatsModel
  func getSimilarHeroesImgPaths() -> Observable<[String]>
  
}

class HeroDetailInteractor: HeroDetailUseCase {
  
  weak var presenter: HeroDetailPresenterProtocol?
  private let repository: HeroStatsRepositoryProtocol
  private let hero: HeroStatsModel
  
  required init(repository: HeroStatsRepositoryProtocol, hero: HeroStatsModel) {
    self.repository = repository
    self.hero = hero
    
  }
  
  func getHero() -> HeroStatsModel {
    return hero
  }
  
  func getSimilarHeroesImgPaths() -> Observable<[String]> {
    
    return self.repository.getSimilarHeroImgPaths(attribute: hero.primaryAttr)
    
  }
  
  
}
