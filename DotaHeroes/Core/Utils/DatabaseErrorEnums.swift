//
//  DatabaseErrorEnums.swift
//  DotaHeroes
//
//  Created by Indra Permana on 29/06/21.
//

import Foundation
enum DatabaseError: LocalizedError {

  case invalidInstance
  case requestFailed
  
  var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    }
  }

}
