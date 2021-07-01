//
//  HomePresenter.swift
//  DotaHeroes
//
//  Created by Indra Permana on 30/06/21.
//

import Foundation
import RxSwift

protocol HomePresenterProtocol: AnyObject {
  
  var interactor: HeroStatsUseCase? { get set }
  var view: HomeViewProtocol? { get set }
  var router: HomeRouterProtocol? { get set }
  func loadHeroStats()
  func goToHeroDetail(with: HeroStatsModel)
  
}

class HomePresenter: HomePresenterProtocol {
  
  var interactor: HeroStatsUseCase?
  var router: HomeRouterProtocol?
  weak var view: HomeViewProtocol?
  private var bags = DisposeBag()
  
  private var heroes: [HeroStatsModel] = []
  
}

extension HomePresenter {
  
  public func loadHeroStats() {
    view?.startLoading()
    
    interactor?.getHeroStats(role: nil)
      .observeOn(MainScheduler.instance)
      .subscribe() { result in
        self.heroes = result
//        print(self.heroes[0].roles)
      } onError: { Error in
        print("error: \(Error)")
      } onCompleted: {
        self.view?.stopLoading()
        self.view?.displayHeroes(self.heroes)
      }
      .disposed(by: bags)
    
  }
  
  public func goToHeroDetail(with hero: HeroStatsModel) {
    
    self.router?.goToHeroDetail(with: hero)
    
  }
  
}
