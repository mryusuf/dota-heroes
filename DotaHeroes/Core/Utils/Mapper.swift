//
//  Mapper.swift
//  DotaHeroes
//
//  Created by Indra Permana on 29/06/21.
//

import Foundation

final class Mapper {
  
  static func mapResponsesToEntity (input response: [HeroStats]) -> [HeroStatEntity] {
    
    return response.map { hero in
      
      let heroStatEntity = HeroStatEntity()
      heroStatEntity.id = hero.id
      heroStatEntity.name = hero.localized_name
      heroStatEntity.primaryAttr = hero.primary_attr
      heroStatEntity.attackType = hero.attack_type
      heroStatEntity.baseHealth = hero.base_health
      heroStatEntity.baseAttackMin = hero.base_attack_min
      heroStatEntity.baseAttackMax = hero.base_attack_max
      heroStatEntity.baseAgi = hero.base_agi
      heroStatEntity.baseInt = hero.base_int
      heroStatEntity.imageUrlPath = hero.img
      let roles = hero.roles
      for role in roles {
        heroStatEntity.roles.append(role)
      }
      
      return heroStatEntity
    }
    
  }
  
  static func mapEntityToDomain (input entity: [HeroStatEntity]) -> [HeroStatsModel] {
    
    return entity.map { hero in
      
      var roles: [String] = []
      for role in hero.roles {
        roles.append(role)
      }
      
      return HeroStatsModel(
        id: hero.id,
        name: hero.name,
        primaryAttr: hero.primaryAttr,
        attackType: hero.attackType,
        roles: roles,
        baseHealth: hero.baseHealth,
        baseAttackMin: hero.baseAttackMin,
        baseAttackMax: hero.baseAttackMax,
        baseAgi: hero.baseAgi,
        baseInt: hero.baseInt,
        imgUrlPath: hero.imageUrlPath)
    }
  }
  
}
