//
//  DataBase.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 24/12/22.
//

import Foundation
import RealmSwift

class DataBase{
    
    private var realm: Realm? = nil
    
    init() {
        do {
            try realm = Realm()
        }catch {
            print("DataBase not Realm init")
        }
    }
    
    func saveModel<T: Object>(model: T) {
        do {
            try realm?.write{
                realm?.add(model, update: .all)
            }
        }catch {
            print("DataBase saveModel not work")
        }
    }
    
    func getModel<T: Object>() -> Results<T>? {
        return realm?.objects(T.self)
    }
}
