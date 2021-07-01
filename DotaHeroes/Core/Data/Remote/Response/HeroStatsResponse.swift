//
//  HeroStatsResponse.swift
//  DotaHeroes
//
//  Created by Indra Permana on 29/06/21.
//

import Foundation

struct HeroStatsResponses: Codable {
  let heroStats: [HeroStats]
}

struct HeroStats: Codable {
  
  let id: Int
  let localized_name: String
  let primary_attr: String
  let attack_type: String
  let roles: [String]
  let base_health: Int
  let base_attack_min: Int
  let base_attack_max: Int
  let base_agi: Int
  let base_int: Int
  let img: String
  
}

