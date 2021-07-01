//
//  RootRouter.swift
//  DotaHeroes
//
//  Created by Indra Permana on 30/06/21.
//

import UIKit

class RootRouter {
  var homeViewController: UINavigationController?
  
  func setup(window: UIWindow) {
    
    homeViewController = buildHome()
    window.rootViewController = homeViewController
    
  }
  
  func buildHome() -> UINavigationController {
    var interactor = Injection.init().provideHeroStats()
    let view = HomeViewController()
    let presenter = HomePresenter()
    let router = HomeRouter()
    
    view.presenter = presenter
    
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    interactor.presenter = presenter
    
    router.presenter = presenter
    router.viewController = view
    
    let nVC = UINavigationController(rootViewController: view)
    return nVC
  }
}
