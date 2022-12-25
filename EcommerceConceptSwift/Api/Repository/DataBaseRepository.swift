//
//  DataBaseRepository.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 24/12/22.
//

import Foundation
import RealmSwift

class DataBaseRepository{
    private var dataBase = DataBase()
    private static var instanse = DataBaseRepository()
    
    static func newInstanse() -> DataBaseRepository {
        return instanse
    }
    
    func saveMyCarts(model: MyCartDatabaseModel) {
        dataBase.saveModel(model: model)
    }
    
    func getSavedMyCarts() -> Results<MyCartDatabaseModel>? {
        return dataBase.getModel()
    }
}
