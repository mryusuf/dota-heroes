//
//  HeroStatsModel.swift
//  DotaHeroes
//
//  Created by Indra Permana on 29/06/21.
//

import Foundation
import RxDataSources

struct HeroStatsModel: Equatable, Identifiable {
  
  let id: Int
  let name: String
  let primaryAttr: String
  let attackType: String
  let roles: [String]
  let baseHealth: Int
  let baseAttackMin: Int
  let baseAttackMax: Int
  let baseAgi: Int
  let baseInt: Int
  let imgUrlPath: String
  
}

extension HeroStatsModel: IdentifiableType {
    
    typealias Identity = Int
    
    var identity: Int {
        return id
    }
    
    static func == (lhs: HeroStatsModel, rhs: HeroStatsModel) -> Bool {
        return lhs.id == rhs.id
    }
}
