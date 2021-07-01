//
//  HeroStatEntity.swift
//  DotaHeroes
//
//  Created by Indra Permana on 29/06/21.
//

import Foundation
import RealmSwift

class HeroStatEntity: Object {
  
  @objc dynamic var id: Int = 0
  @objc dynamic var name: String = ""
  @objc dynamic var primaryAttr: String = ""
  @objc dynamic var attackType: String = ""
  let roles = List<String>()
  @objc dynamic var baseHealth: Int = 0
  @objc dynamic var baseAttackMin: Int = 0
  @objc dynamic var baseAttackMax: Int = 0
  @objc dynamic var baseAgi: Int = 0
  @objc dynamic var baseInt: Int = 0
  @objc dynamic var imageUrlPath: String = ""
  
  override class func primaryKey() -> String? {
    return "id"
  }
  
}
