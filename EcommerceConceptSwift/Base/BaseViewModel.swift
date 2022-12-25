//
//  BaseViewModel.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 14/12/22.
//

import Foundation

class BaseViewModel {
    var apiClient = ApiRepository.newInstanse()
    var dataBase = DataBaseRepository.newInstanse()
}
