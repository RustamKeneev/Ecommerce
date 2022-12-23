//
//  HomeStore.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 14/12/22.
//

import Foundation
import UIKit

// MARK: - HomeStore
struct HomeStore: Codable {
    var id: Int? = nil
    var isNew: Bool? = nil
    var title: String? = nil, subtitle: String? = nil
    var picture: String? = nil
    var isBuy: Bool? = nil

    enum CodingKeys: String, CodingKey {
        case id
        case isNew = "is_new"
        case title, subtitle, picture
        case isBuy = "is_buy"
    }
}

typealias HomeStories = [HomeStore]
