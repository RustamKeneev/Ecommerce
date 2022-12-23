//
//  MyCartModel.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 22/12/22.
//

import Foundation
import UIKit

struct MyCartModel{
    var id: Int
    var image: UIImage
    var text: String
    var discountPrice: Int
    
    init(id: Int, image: UIImage, text: String, discountPrice: Int) {
        self.id = id
        self.image = image
        self.text = text
        self.discountPrice = discountPrice
    }
}
