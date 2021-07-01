//
//  HeroCollectionViewCell.swift
//  DotaHeroes
//
//  Created by Indra Permana on 30/06/21.
//

import UIKit
import SDWebImage

class HeroCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var heroImageView: UIImageView!
  @IBOutlet weak var heroNameLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func setup(name: String, imageUrlPath: String) {
    heroNameLabel.text = name
    heroImageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
    let imageUrl = API.baseUrl + imageUrlPath
    heroImageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
  }
  
}
