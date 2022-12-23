//
//  HomeModel.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 14/12/22.
//

import Foundation
import UIKit

// MARK: - Welcome
struct HomeModel: Codable {
    var homeStore: [HomeStore]
    var bestSeller: [BestSeller]

    enum CodingKeys: String, CodingKey {
        case homeStore = "home_store"
        case bestSeller = "best_seller"
    }
}

typealias HomeModelies = [HomeModel]
