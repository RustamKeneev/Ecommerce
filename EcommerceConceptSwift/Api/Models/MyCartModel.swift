//
//  MyCartModel.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 22/12/22.
//

import Foundation
import UIKit

struct MyCartModel{
    var id: Int? = nil
    var image: String? = nil
    var text: String? = nil
    var discountPrice: Int? = nil
    
//    init(id: Int, image: String, text: String, discountPrice: Int) {
//        self.id = id
//        self.image = image
//        self.text = text
//        self.discountPrice = discountPrice
//    }
    
    
    func toDataBaseModel() -> MyCartDatabaseModel {
        let model = MyCartDatabaseModel()
        model.id = String(id ?? 0)
        model.image = image ?? String()
        model.text = text ?? String()
        model.discountPrice = String(discountPrice ?? 0)
        return model
    }
}
