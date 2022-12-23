//
//  ProductCharacterDetailViewModel.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 19/12/22.
//

import Foundation
import UIKit

protocol ProductCharacterDetailViewModelDelegate: AnyObject {
    func loadProductCharacterDetail()
}

class ProductCharacterDetailViewModel{
    
    var productCharacterDetailArrayData: [ProductCharacterDetail] = []
    weak var delegate : ProductCharacterDetailViewModelDelegate?
    
    init(delegate: ProductCharacterDetailViewModelDelegate) {
           self.delegate = delegate
       }

    func fetchProductCharacterDetail() {
        productCharacterDetailArrayData.append(ProductCharacterDetail(image: #imageLiteral(resourceName: "processor"), text: "Exynos 990"))
        productCharacterDetailArrayData.append(ProductCharacterDetail(image: #imageLiteral(resourceName: "camera"), text: "108 + 12 mp"))
        productCharacterDetailArrayData.append(ProductCharacterDetail(image: #imageLiteral(resourceName: "chip"), text: "8 GB"))
        productCharacterDetailArrayData.append(ProductCharacterDetail(image: #imageLiteral(resourceName: "memory"), text: "256 GB"))
        delegate?.loadProductCharacterDetail()
    }
}
