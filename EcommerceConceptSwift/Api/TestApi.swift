////
////  TestApi.swift
////  EcommerceConceptSwift
////
////  Created by Rustam Keneev on 14/12/22.
////
//
//import Foundation
//
//struct TestResponse: Decodable {
//    var id: Int
//    var is_new: Bool
//
//    private enum HomeStoreResponseKeys: String, CodingKey {
//        case home_store
//        case best_seller
//    }
//
//    private enum HomeStoreKeys: String, CodingKey {
//        case id = "id"
//        case is_new = "is_new"
//    }
//
//    init(from decoder: Decoder) throws {
//        if let homeStoreResponseContainer = try? decoder.container(keyedBy: HomeStoreResponseKeys.self){
//            if let mainContainer = try? homeStoreResponseContainer.nestedContainer(keyedBy: HomeStoreKeys.self, forKey: .home_store){
//                self.id = try mainContainer.decode(Int.self, forKey: .id)
//                self.is_new = try mainContainer.decode(Bool.self, forKey: .is_new)
//            }
//        }
//    }
//}
