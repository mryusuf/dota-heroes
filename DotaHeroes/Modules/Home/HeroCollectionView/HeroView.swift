//
//  HeroView.swift
//  DotaHeroes
//
//  Created by Indra Permana on 30/06/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

protocol HeroViewProtocol: AnyObject {
  
  func didSelectHero(_ hero: HeroStatsModel)
  
}
class HeroView: UIView {

  private weak var heroesCollectionView: UICollectionView?
  private let cellName = "HeroCollectionViewCell"
  private var heroes: [HeroStatsModel] = []
  private var heroDataSource: RxCollectionViewSectionedReloadDataSource<HeroSection>?
  private var heroSubject: PublishSubject<[HeroSection]>?
  private var isLoading = false
  private var bags = DisposeBag()
  weak var delegate: HeroViewProtocol?

}

extension HeroView {
  
  private func loadSection() -> [HeroSection] {
    let header = "Heroes"
    let sections = [HeroSection(header: header, items: heroes)]
    return sections
  }
  
  func setup() {
    setupCollectionView()
    setupRxDataSource()
  }
  
  private func setupCollectionView() {
    
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.rx.setDelegate(self).disposed(by: bags)
    collectionView.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
    addSubview(collectionView)
    
    let zero = CGFloat(0)
    collectionView.contentInset = UIEdgeInsets(top: zero, left: zero, bottom: zero, right: zero)
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.center.equalToSuperview()
    }
    
    self.heroesCollectionView = collectionView
  }
  
  private func setupRxDataSource() {
    guard let heroesCollectionView = heroesCollectionView else {
      return
    }
    
    let subject = PublishSubject<[HeroSection]>()
    let dataSource = RxCollectionViewSectionedReloadDataSource<HeroSection>(
    
      configureCell: { _,collectionView,indexPath,item in
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: self.cellName, for: indexPath) as? HeroCollectionViewCell
        else {
          return UICollectionViewCell()
        }
        
        cell.setup(name: item.name, imageUrlPath: item.imgUrlPath)
        return cell
        
      }
    )
    
    subject
      .bind(to: heroesCollectionView.rx.items(dataSource: dataSource))
      .disposed(by: bags)
    
    self.heroSubject = subject
    self.heroDataSource = dataSource
  }
  
  func displayHeroes(_ heroes: [HeroStatsModel]) {
    
    guard !isLoading, let heroSubject = heroSubject else {
      return
    }
    
    isLoading = true
    self.heroes = heroes
    heroSubject.onNext(loadSection())
    isLoading = false
    
  }
}

extension HeroView: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    guard let heroDataSource = heroDataSource else { return }
    let selectedHero = heroDataSource[indexPath]
    delegate?.didSelectHero(selectedHero)
    
  }
}

extension HeroView: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
      
    let width = collectionView.bounds.size.width / 2 - 20
    let height = collectionView.bounds.size.height / 4 - 20
    return CGSize( width: width, height: height )
  }
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return CGFloat(16)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets.init(top: 8, left: 20, bottom: 8, right: 8)
  }
}

extension HeroView: UIScrollViewDelegate {
  
}
