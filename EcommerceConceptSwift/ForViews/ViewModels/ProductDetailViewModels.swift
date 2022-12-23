//
//  ProductDetailViewModels.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 19/12/22.
//

import Foundation
import UIKit

protocol ProductDetailViewModelsDelegate: AnyObject {
    func loadProductdetail()
}

class ProductDetailViewModels{
    
    var productDetailArrayData: [ProductDetailPagingModel] = []
    weak var delegate : ProductDetailViewModelsDelegate?
    
    init(delegate: ProductDetailViewModelsDelegate) {
           self.delegate = delegate
       }

    func fetchProductDetail() {
        productDetailArrayData.append(ProductDetailPagingModel(title: "Shop", color: .clear))
        productDetailArrayData.append(ProductDetailPagingModel(title: "Details", color: .clear))
        productDetailArrayData.append(ProductDetailPagingModel(title: "Features", color: .clear))
        delegate?.loadProductdetail()
    }
}
