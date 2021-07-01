//
//  Results+Ext.swift
//  DotaHeroes
//
//  Created by Indra Permana on 29/06/21.
//

import Foundation
import RealmSwift

extension Results {
  
  public func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
}
