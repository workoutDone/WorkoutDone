//
//  RealmManager.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/04/30.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    let realm = try! Realm()
    private init() {}
    
    ///create
    func createData<T>(data: T) {
        do {
            try realm.write {
                if let dataArray = data as? [Object] {
                    realm.add(dataArray)
                } else if let object = data as? Object {
                    realm.add(object)
                } else {
                    print("Unsupported data type: \(type(of: data))")
                }
            }
        } catch {
            print("Error saving data: \(error)")
        }
    }
}
