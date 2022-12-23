//
//  TestViewModel.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 14/12/22.
//

import Foundation
import UIKit


protocol TestViewModelDelegate: AnyObject {
    func loadHomeModel(models: HomeModelies)
}

class TestViewModel: BaseViewModel {
    private weak var delegate: TestViewModelDelegate? = nil
    var homeData: [HomeModel] = HomeModelies()
    
    init(delegate: TestViewModelDelegate) {
        self.delegate = delegate
    }
    
    func getAboutHomeData() {
        apiClient.getHomeData { [self] model, message, error in
            self.homeData = model ?? []
            self.delegate?.loadHomeModel(models: homeData)
        }
    }
}

