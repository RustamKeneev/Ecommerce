//
//  MyCartDatabaseModel.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 24/12/22.
//

import Foundation
import RealmSwift

class MyCartDatabaseModel: Object{
    @objc dynamic var id: String? = nil
    @objc dynamic var image: String? = nil
    @objc dynamic var text: String? = nil
    @objc dynamic var discountPrice: String? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func toModel() -> MyCartModel {
        var model = MyCartModel()
        model.id = Int(id ?? "0")
        model.image = image
        model.text = text
        model.discountPrice = Int(discountPrice ?? "0")
        return model
    }
    
}


