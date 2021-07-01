//
//  API.swift
//  Dota Heroes
//
//  Created by Indra Permana on 28/06/21.
//

import Foundation

struct API {
  
  static let baseUrl = "https://api.opendota.com"
  
}

protocol Endpoint {
  
  var url: String { get }
  
}

enum Endpoints {
  
  enum Gets: Endpoint {
    
    case heroStats
    case baseUrl
    
    public var url: String {
      switch self {
      case .heroStats:
        return API.baseUrl + "/api/herostats"
      case .baseUrl:
        return API.baseUrl
        
      }
    }
      
  }
}
