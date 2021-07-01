//
//  HomeRouter.swift
//  DotaHeroes
//
//  Created by Indra Permana on 30/06/21.
//

import UIKit

protocol HomeRouterProtocol: AnyObject {
  
  var presenter: HomePresenterProtocol? { get set }
  func goToHeroDetail(with hero: HeroStatsModel)
  
}

class HomeRouter: HomeRouterProtocol {
  
  weak var presenter: HomePresenterProtocol?
  weak var viewController: UIViewController?
  
}

extension HomeRouter {
  
  func goToHeroDetail(with hero: HeroStatsModel) {
    
    let heroDetailVC = buildHeroDetail(with: hero)
    self.viewController?.navigationController?.pushViewController(heroDetailVC, animated: true)
    
  }
  
  func buildHeroDetail(with hero: HeroStatsModel) -> UIViewController {
    let view = HeroDetailViewController()
    let interactor = Injection.init().provideHeroStatDetail(with: hero)
    let presenter = HeroDetailPresenter()
    let router = HeroDetailRouter()
    
    view.presenter = presenter
    
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    interactor.presenter = presenter
    
    return view
    
  }
  
}
