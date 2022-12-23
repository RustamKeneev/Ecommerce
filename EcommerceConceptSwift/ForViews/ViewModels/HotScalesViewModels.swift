//
//  HotScalesViewModels.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 12/12/22.
//

import Foundation
import UIKit

protocol HotScalesViewModelsDelegate: AnyObject {
    func loadHotScales()
}

class HotScalesViewModels{
    
    var hotScalesArrayData: [HotScalesModel] = []
    
    weak var delegate : HotScalesViewModelsDelegate?
    
    init(delegate: HotScalesViewModelsDelegate) {
           self.delegate = delegate
       }

    func fetchSHotScales() {
        hotScalesArrayData.append(HotScalesModel(id: 1, image: #imageLiteral(resourceName: "hot_scales_test"), title: "Iphone 12", subTitle: "Súper. Mega. Rápido."))
        hotScalesArrayData.append(HotScalesModel(id: 1, image: #imageLiteral(resourceName: "hot_scales_test"), title: "Iphone 12", subTitle: "Súper. Mega. Rápido."))
        hotScalesArrayData.append(HotScalesModel(id: 1, image: #imageLiteral(resourceName: "hot_scales_test"), title: "Iphone 12", subTitle: "Súper. Mega. Rápido."))
        delegate?.loadHotScales()
    }
}
