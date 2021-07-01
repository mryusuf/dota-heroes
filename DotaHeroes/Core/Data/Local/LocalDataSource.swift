//
//  LocalDataSource.swift
//  DotaHeroes
//
//  Created by Indra Permana on 29/06/21.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocalDataSourceProtocol {
  
  func getHeroStats(role: String?) -> Observable<[HeroStatEntity]>
  func addHeroStats(heroes: [HeroStatEntity]) -> Observable<Bool>
  func getSimilarHeroImgPaths(attribute: String) -> Observable<[String]>
  
}

final class LocalDataSource: NSObject {
  
  private let realm: Realm?
  
  private init(realm: Realm?) {
    self.realm = realm
  }
  
  static let shared: (Realm?) -> LocalDataSource = { realmDB in
    return LocalDataSource(realm: realmDB)
  }
  
}

extension LocalDataSource: LocalDataSourceProtocol {
  
  func getHeroStats(role: String?) -> Observable<[HeroStatEntity]> {
    return Observable<[HeroStatEntity]>.create { observer in
      let heroes: Results<HeroStatEntity>
      if let realm = self.realm {
        if let role = role {
          let predicate = NSPredicate(format: "\(role) IN role")
          heroes = {
            realm.objects(HeroStatEntity.self)
              .filter(predicate)
          }()
        } else {
          heroes = {
            realm.objects(HeroStatEntity.self)
          }()
        }
        observer.onNext(heroes.toArray(ofType: HeroStatEntity.self))
        observer.onCompleted()
      } else {
        observer.onError(DatabaseError.invalidInstance)
      }
      
      return Disposables.create()
    }
  }
  
  func addHeroStats(heroes: [HeroStatEntity]) -> Observable<Bool> {
    return Observable<Bool>.create { observer in
      if let realm = self.realm {
        do {
          try realm.write {
            for hero in heroes {
              realm.add(hero, update: .all)
            }
            observer.onNext(true)
            observer.onCompleted()
          }
        } catch {
          observer.onError(DatabaseError.requestFailed)
        }
      } else {
        observer.onError(DatabaseError.invalidInstance)
      }
      return Disposables.create()
    }
  }
  
  func getSimilarHeroImgPaths(attribute: String) -> Observable<[String]> {
    var attributeToFilter = ""
    if attribute == "str" {
      attributeToFilter = "baseAttackMax"
    } else if attribute == "agi" {
      attributeToFilter = "baseAgi"
    } else {
      attributeToFilter = "baseInt"
    }
    
    return Observable<[String]>.create { observer in
      if let realm = self.realm {
        let heroes = {
          realm.objects(HeroStatEntity.self)
            .sorted(byKeyPath: attributeToFilter, ascending: false)
        }()
        
        var results: [String] = []
        for i in 0..<3 {
          results.append(heroes[i].imageUrlPath)
        }
        
        observer.onNext(results)
        observer.onCompleted()
        
      } else {
        observer.onError(DatabaseError.invalidInstance)
      }
      return Disposables.create()
    }
  }
  
}
