//
//  HeroDetailViewController.swift
//  DotaHeroes
//
//  Created by Indra Permana on 30/06/21.
//

import UIKit
import SDWebImage
import SnapKit

protocol HeroDetailViewProtocol: AnyObject {
  
  func displayHero(with hero: HeroStatsModel)
  func displaySimilarHeroes(with heroesImgPaths: [String])
  
}

class HeroDetailViewController: UIViewController {
  
  var presenter: HeroDetailPresenterProtocol?
  private weak var leftStackView: UIStackView?
  private weak var rightStackView: UIStackView?
  private weak var similarHeroesStackView: UIStackView?
  
  private var heroName: String?
  
  init() {
    super.init(nibName: nil, bundle: nil)
    self.title = ""
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    
  }
  
  override func loadView() {
    super.loadView()
    
    self.view.backgroundColor = .systemBackground
    self.presenter?.loadHeroDetail()
  }
  
}

extension HeroDetailViewController: HeroDetailViewProtocol {
  
  func displayHero(with hero: HeroStatsModel) {
    
    let heroImageView = UIImageView()
    heroImageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
    let imageUrl = API.baseUrl + hero.imgUrlPath
    heroImageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
    heroImageView.layer.masksToBounds = true
    heroImageView.layer.cornerRadius = 10.0
    let heroImageViewConstraint = heroImageView.heightAnchor.constraint(equalToConstant: (self.view.bounds.width / 2 - 20))
    heroImageViewConstraint.isActive = true
    heroImageViewConstraint.priority = UILayoutPriority(rawValue: 999)
    heroImageView.contentMode = .scaleToFill
    
    let heroNameLabel = UILabel()
    heroNameLabel.text = hero.name
    heroNameLabel.font = .boldSystemFont(ofSize: 18)
    heroNameLabel.textAlignment = .left
    
    let roleLabel = UILabel()
    roleLabel.numberOfLines = 0
    roleLabel.text = "\nRole: \n\(hero.roles.joined(separator: ", "))"
    roleLabel.textAlignment = .left
    
    let leftStackView = UIStackView()
    leftStackView.axis = .vertical
    leftStackView.alignment = .top
    leftStackView.distribution = .fill
    leftStackView.addArrangedSubview(heroImageView)
    leftStackView.addArrangedSubview(heroNameLabel)
    leftStackView.addArrangedSubview(roleLabel)
    
    self.view.addSubview(leftStackView)
    
    leftStackView.snp.makeConstraints { make in
      make.width.equalToSuperview().dividedBy(2).offset(10)
      make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(10)
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
    }
    
    let attackImageView = UIImageView()
    attackImageView.image = UIImage(named: "attack")
    let attackImageViewHeightConstraint = attackImageView.heightAnchor.constraint(equalToConstant: 40)
    let attackImageViewWidthConstraint = attackImageView.widthAnchor.constraint(equalToConstant: 40)
    attackImageViewHeightConstraint.isActive = true
    attackImageViewWidthConstraint.isActive = true
    attackImageView.contentMode = .scaleToFill
    
    let attackValueLabel = UILabel()
    attackValueLabel.text = " \(hero.baseAttackMin) - \(hero.baseAttackMax)"
    
    let maxAttackStackView = UIStackView()
    maxAttackStackView.axis = .horizontal
    maxAttackStackView.distribution = .fill
    maxAttackStackView.spacing = 8
    maxAttackStackView.addArrangedSubview(attackImageView)
    maxAttackStackView.addArrangedSubview(attackValueLabel)
    
    let healthImageView = UIImageView()
    healthImageView.image = UIImage(named: "health")
    let healthImageViewHeightConstraint = healthImageView.heightAnchor.constraint(equalToConstant: 40)
    let healthImageViewWidthConstraint = healthImageView.widthAnchor.constraint(equalToConstant: 40)
    healthImageViewHeightConstraint.isActive = true
    healthImageViewWidthConstraint.isActive = true
    healthImageView.contentMode = .scaleToFill
    
    let healthValueLabel = UILabel()
    healthValueLabel.text = hero.baseHealth.description
    
    let healthStackView = UIStackView()
    healthStackView.axis = .horizontal
    healthStackView.distribution = .fill
    healthStackView.spacing = 8
    healthStackView.addArrangedSubview(healthImageView)
    healthStackView.addArrangedSubview(healthValueLabel)
    
    let agiImageView = UIImageView()
    agiImageView.image = UIImage(named: "agi")
    let agiImageViewHeightConstraint = agiImageView.heightAnchor.constraint(equalToConstant: 40)
    let agiImageViewWidthConstraint = agiImageView.widthAnchor.constraint(equalToConstant: 40)
    agiImageViewHeightConstraint.isActive = true
    agiImageViewWidthConstraint.isActive = true
    agiImageView.contentMode = .scaleToFill
    
    let agiValueLabel = UILabel()
    agiValueLabel.text = hero.baseAgi.description
    
    let agiStackView = UIStackView()
    agiStackView.axis = .horizontal
    agiStackView.distribution = .fill
    agiStackView.spacing = 8
    agiStackView.addArrangedSubview(agiImageView)
    agiStackView.addArrangedSubview(agiValueLabel)
    
    
    let manaImageView = UIImageView()
    manaImageView.image = UIImage(named: "mana")
    let manaImageViewHeightConstraint = manaImageView.heightAnchor.constraint(equalToConstant: 40)
    let manaImageViewWidthConstraint = manaImageView.widthAnchor.constraint(equalToConstant: 40)
    manaImageViewHeightConstraint.isActive = true
    manaImageViewWidthConstraint.isActive = true
    manaImageView.contentMode = .scaleToFill
    
    let manaValueLabel = UILabel()
    manaValueLabel.text = hero.baseInt.description
    
    let manaStackView = UIStackView()
    manaStackView.axis = .horizontal
    manaStackView.distribution = .fill
    manaStackView.spacing = 8
    manaStackView.addArrangedSubview(manaImageView)
    manaStackView.addArrangedSubview(manaValueLabel)
    
    
    let attributeImageView = UIImageView()
    attributeImageView.image = UIImage(named: "attribute")
    attributeImageView.tintColor = .systemFill
    let attributeImageViewHeightConstraint = attributeImageView.heightAnchor.constraint(equalToConstant: 40)
    let attributeImageViewWidthConstraint = attributeImageView.widthAnchor.constraint(equalToConstant: 40)
    attributeImageViewHeightConstraint.isActive = true
    attributeImageViewWidthConstraint.isActive = true
    attributeImageView.contentMode = .scaleToFill
    
    let attributeValueLabel = UILabel()
    attributeValueLabel.text = hero.primaryAttr.description
    
    let attributeStackView = UIStackView()
    attributeStackView.axis = .horizontal
    attributeStackView.distribution = .fill
    attributeStackView.spacing = 8
    attributeStackView.addArrangedSubview(attributeImageView)
    attributeStackView.addArrangedSubview(attributeValueLabel)
    
    let rightStackView = UIStackView()
    rightStackView.axis = .vertical
    rightStackView.alignment = .top
    rightStackView.distribution = .fillEqually
    rightStackView.spacing = 8
    rightStackView.addArrangedSubview(maxAttackStackView)
    rightStackView.addArrangedSubview(healthStackView)
    rightStackView.addArrangedSubview(agiStackView)
    rightStackView.addArrangedSubview(manaStackView)
    rightStackView.addArrangedSubview(attributeStackView)
    
    self.view.addSubview(rightStackView)
    
    rightStackView.snp.makeConstraints { make in
      make.width.equalToSuperview().dividedBy(2).offset(10)
      make.leading.equalTo(leftStackView.snp.trailing).offset(10)
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
    }
    
    self.rightStackView = rightStackView
    self.leftStackView = leftStackView
    
  }
  
  func displaySimilarHeroes(with heroesImgPaths: [String]) {
    
    guard let rightStackView = rightStackView, let leftStackView = leftStackView else {
      return
    }
    
    let similarHeroesLabel = UILabel()
    similarHeroesLabel.text = "Similar Heroes:"
    
    let similarHeroesStackView = UIStackView()
    similarHeroesStackView.axis = .vertical
    similarHeroesStackView.distribution = .fill
    similarHeroesStackView.spacing = 8
    similarHeroesStackView.addArrangedSubview(similarHeroesLabel)
    
    let similarHeroesImagesStackView = UIStackView()
    similarHeroesImagesStackView.axis = .horizontal
    similarHeroesImagesStackView.distribution = .fillProportionally
    similarHeroesImagesStackView.spacing = 8
    
    for heroesImgPath in heroesImgPaths {
      let similarHeroImageView = UIImageView()
      similarHeroImageView.sd_imageIndicator =  SDWebImageActivityIndicator.medium
      let imageURL = API.baseUrl + heroesImgPath
      similarHeroImageView.sd_setImage(with: URL(string: imageURL), completed: nil)
      similarHeroImageView.layer.masksToBounds = true
      similarHeroImageView.layer.cornerRadius = 10.0
      let similarHeroImageViewConstraint = similarHeroImageView.heightAnchor.constraint(equalToConstant: (50))
      similarHeroImageViewConstraint.isActive = true
      similarHeroImageViewConstraint.priority = UILayoutPriority(rawValue: 999)
      similarHeroImageView.contentMode = .scaleToFill
      similarHeroesImagesStackView.addArrangedSubview(similarHeroImageView)
    }
    
    similarHeroesStackView.addArrangedSubview(similarHeroesImagesStackView)
    
    self.view.addSubview(similarHeroesStackView)
    
    let isPortrait = UIDevice.current.orientation.isPortrait
    
    
    similarHeroesStackView.snp.makeConstraints { make in
      make.top.equalTo(isPortrait ? leftStackView.snp.bottom : rightStackView.snp.bottom).offset(20)
      make.leading.equalTo(isPortrait ? self.view.safeAreaLayoutGuide.snp.leading : leftStackView.snp.trailing).offset(10)
      make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(isPortrait ? 20 : 0)
    }
    
    self.similarHeroesStackView = similarHeroesStackView
  }
  
}

extension HeroDetailViewController {
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    
    guard let rightStackView = rightStackView, let leftStackView = leftStackView, let similarHeroesStackView = similarHeroesStackView else {
      
      return
    }
    
    coordinator.animate(alongsideTransition: { _ in
      
      let isPortrait = UIDevice.current.orientation.isPortrait
      
      similarHeroesStackView.snp.remakeConstraints { make in
        make.top.equalTo(isPortrait ? leftStackView.snp.bottom : rightStackView.snp.bottom).offset(20)
        make.leading.equalTo(isPortrait ? self.view.safeAreaLayoutGuide.snp.leading : leftStackView.snp.trailing).offset(10)
        make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
          .offset(isPortrait ? 20 : 0)
      }
    }, completion: { _ in
      print("rotation completed")
    })
    
    super.viewWillTransition(to: size, with: coordinator)
    
  }
  
  override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
    super.willTransition(to: newCollection, with: coordinator)
    
    
    
  }
}
