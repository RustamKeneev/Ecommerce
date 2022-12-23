//
//  HomeStoreViewModel.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 14/12/22.
//

import Foundation
import UIKit

protocol HomeStoreViewModelDelegate: AnyObject {
    func loadHomeStore(models: HomeStories)
}

class HomeStoreViewModel: BaseViewModel {
    private weak var delegate: HomeStoreViewModelDelegate? = nil
    var homeStoreData: [HomeStore] = HomeStories()
    
    init(delegate: HomeStoreViewModelDelegate) {
        self.delegate = delegate
    }
    
    func getHomeStoreData() {
        apiClient.getHomeStore { [self] model, message, error in
            self.homeStoreData = model ?? []
            self.delegate?.loadHomeStore(models: homeStoreData)
        }
    }
}
