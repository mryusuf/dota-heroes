//
//  HeroSection.swift
//  DotaHeroes
//
//  Created by Indra Permana on 30/06/21.
//

import Foundation
import RxDataSources

struct HeroSection {
  
  var header: String
  var items: [Item]
  var id = "1"
  
}

extension HeroSection: AnimatableSectionModelType {
  
  typealias Identity = String
  typealias Item = HeroStatsModel
  
  init(original: HeroSection, items: [HeroStatsModel]) {
    self = original
    self.items = items
  }
  
  var identity: String {
    return "id"
  }
  
}
