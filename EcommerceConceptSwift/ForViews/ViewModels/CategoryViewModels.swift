//
//  CategoryViewModels.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 12/12/22.
//

import Foundation
import UIKit

protocol CategoryViewModelsDelegate: AnyObject {
    func loadCategory()
}

class CategoryViewModels{
    
    var catalogsArrayData: [CategoryModel] = []
    weak var delegate : CategoryViewModelsDelegate?
    
    init(delegate: CategoryViewModelsDelegate) {
           self.delegate = delegate
       }

    func fetchSCategory() {
        catalogsArrayData.append(CategoryModel(image:  #imageLiteral(resourceName: "phones_dark"), text: "Phones"))
        catalogsArrayData.append(CategoryModel(image:  #imageLiteral(resourceName: "computers_gray"), text: "Computers"))
        catalogsArrayData.append(CategoryModel(image:  #imageLiteral(resourceName: "health_dark"), text: "Health"))
        catalogsArrayData.append(CategoryModel(image:  #imageLiteral(resourceName: "books_dark"), text: "Books"))
        catalogsArrayData.append(CategoryModel(image:  #imageLiteral(resourceName: "phones_dark"), text: "Phones"))
        delegate?.loadCategory()
    }
}
