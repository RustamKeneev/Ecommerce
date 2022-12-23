//
//  CategoryModel.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 12/12/22.
//

import Foundation
import UIKit

struct CategoryModel{
    var image: UIImage
    var text: String
    
    init(image: UIImage, text: String) {
        self.image = image
        self.text = text
    }
}
