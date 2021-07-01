//
//  HeroDetailPresenter.swift
//  DotaHeroes
//
//  Created by Indra Permana on 30/06/21.
//

import UIKit
import RxSwift

protocol HeroDetailPresenterProtocol: AnyObject {
  
  var interactor: HeroDetailUseCase? { get set }
  var view: HeroDetailViewProtocol? { get set }
  var router: HeroDetailRouterProtocol? { get set }
  func loadHeroDetail()
  func showImage(for image: UIImage)
}

class HeroDetailPresenter {
  
  var interactor: HeroDetailUseCase?
  var router: HeroDetailRouterProtocol?
  weak var view: HeroDetailViewProtocol?
  private var heroes: [String] = []
  private var bags = DisposeBag()
  
}

extension HeroDetailPresenter: HeroDetailPresenterProtocol {
  
  func loadHeroDetail() {
    
    guard let hero = self.interactor?.getHero()else {
      return
    }
    
    self.view?.displayHero(with: hero)
    
    interactor?.getSimilarHeroesImgPaths()
      .observeOn(MainScheduler.instance)
      .subscribe() { result in
        self.heroes = result
//        print(self.heroes)
      } onError: { Error in
        print("error: \(Error)")
      } onCompleted: {
        self.view?.displaySimilarHeroes(with: self.heroes)
      }
      .disposed(by: bags)
  }
  
  func showImage(for image: UIImage) {
    
  }
}
