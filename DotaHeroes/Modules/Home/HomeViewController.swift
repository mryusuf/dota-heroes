//
//  HomeViewController.swift
//  Dota Heroes
//
//  Created by Indra Permana on 28/06/21.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
  
  var presenter: HomePresenterProtocol? { get set }
  func startLoading()
  func stopLoading()
  func displayHeroes(_ heroes: [HeroStatsModel])
  
}

class HomeViewController: UIViewController {

  var presenter: HomePresenterProtocol?
  private var isLoading = false
  private weak var activityIndicator: UIActivityIndicatorView?
  private weak var containerView: UIView?
  private weak var heroView: HeroView?
  
  override func loadView() {
    
    super.loadView()
    print("load View")
    setupIndicatorView()
//    setupContainerView()
    setupHeroView()
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.prefersLargeTitles = false
    self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    self.view.backgroundColor = .systemBackground
    self.title = "Dota Heroes"
    self.presenter?.loadHeroStats()
    
  }
  

}

extension HomeViewController {
  func setupIndicatorView() {
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.color = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    self.view.addSubview(activityIndicator)
    self.activityIndicator = activityIndicator
    
    self.activityIndicator?.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    
  }
  
  func setupHeroView() {
    
    let heroView = HeroView()
    heroView.setup()
    heroView.delegate = self
    self.view.addSubview(heroView)
    
    heroView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    self.heroView = heroView
  }
}

extension HomeViewController: HomeViewProtocol {
  func startLoading() {
    
    isLoading = true
    self.activityIndicator?.isHidden = false
    self.activityIndicator?.startAnimating()
    self.heroView?.isHidden = true
    
  }
  
  func stopLoading() {
    
    self.activityIndicator?.stopAnimating()
    self.activityIndicator?.isHidden = true
    self.heroView?.isHidden = false
    
  }
  
  func displayHeroes(_ heroes: [HeroStatsModel]) {
    
    self.heroView?.displayHeroes(heroes)
    
  }
  
}

extension HomeViewController: HeroViewProtocol {
  
  func didSelectHero(_ hero: HeroStatsModel) {
    
    self.presenter?.goToHeroDetail(with: hero)
  }
  
}

