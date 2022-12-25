//
//  MyCartViewModel.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 22/12/22.
//

import Foundation
import UIKit

protocol MyCartViewModelDelegate: AnyObject {
    func loadMyCart()
}

class MyCartViewModel{
    
    var myCartArrayData: [MyCartModel] = []
    weak var delegate : MyCartViewModelDelegate?
    
    init(delegate: MyCartViewModelDelegate) {
           self.delegate = delegate
       }

    func fetchMyCart() {
//        myCartArrayData.append(MyCartModel(id: 1, image: #imageLiteral(resourceName: "phones_dark"), text: "Galaxy Note 20 Ultra", discountPrice: 1500))
        myCartArrayData.append(MyCartModel(id: 1, image: "", text: "Galaxy Note 20 Ultra", discountPrice: 1500))
        delegate?.loadMyCart()
    }
}
