//
//  ApiRepository.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 13/12/22.
//

import Foundation

class ApiRepository {
    private let apiClient = ApiClient()

    private static let shared = ApiRepository()
    
    static func newInstanse() -> ApiRepository {
        return shared
    }
    
    func getHomeData(completion: @escaping ([HomeModel]?, String?, Error?) -> Void){
        apiClient.sendGetRequest(url: Constants.URL.BASE_URL, completion: completion)
    }
    
    func getHomeStore(completion: @escaping ([HomeStore]?, String?, Error?) -> Void){
        apiClient.sendGetRequest(url: Constants.URL.BASE_URL, completion: completion)
    }
}
