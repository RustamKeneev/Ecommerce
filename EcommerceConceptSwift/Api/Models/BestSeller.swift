//
//  BestSeller.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 14/12/22.
//

import Foundation
import UIKit

// MARK: - BestSeller
struct BestSeller: Codable {
    var id: Int? = nil
    var isFavorites: Bool? = nil
    var title: String? = nil
    var priceWithoutDiscount: Int? = nil, discountPrice: Int? = nil
    var picture: String? = nil

    enum CodingKeys: String, CodingKey {
        case id
        case isFavorites = "is_favorites"
        case title
        case priceWithoutDiscount = "price_without_discount"
        case discountPrice = "discount_price"
        case picture
    }
}
