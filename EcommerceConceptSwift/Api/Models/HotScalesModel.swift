//
//  HotScalesModel.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 12/12/22.
//

import Foundation
import UIKit

struct HotScalesModel{
    var id: Int
    var image: UIImage
    var title: String
    var subTitle: String
    
    init(id:  Int, image: UIImage, title: String, subTitle: String) {
        self.id = id
        self.image = image
        self.title = title
        self.subTitle = subTitle
    }
}
