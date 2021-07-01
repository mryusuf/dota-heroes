//
//  RemoteDataSource.swift
//  DotaHeroes
//
//  Created by Indra Permana on 29/06/21.
//

import Foundation
import Alamofire
import RxSwift

protocol RemoteDataSourceProtocol {
  
  func getHeroStats() -> Observable<[HeroStats]>
  
}

final class RemoteDataSource: NSObject {
  
  private override init() {
    
  }
  
  static let shared: RemoteDataSource = RemoteDataSource()
  
}

extension RemoteDataSource: RemoteDataSourceProtocol {
  
  func getHeroStats() -> Observable<[HeroStats]> {
    return Observable<[HeroStats]>.create { observer in
      if let url = URL(string: Endpoints.Gets.heroStats.url) {
        AF.request(url)
          .validate()
          .responseDecodable(of: [HeroStats].self) { response in
            switch response.result {
            case .success(let values):
              observer.onNext(values)
              observer.onCompleted()
            case .failure(let error):
              observer.onError(error)
              
            }
          }
      }
      return Disposables.create()
    }
  }
  
}
