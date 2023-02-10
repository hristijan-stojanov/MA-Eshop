//
//  APIdata.swift
//  E-shop
//
//  Created by SOCD on 2/6/23.
//  Copyright © 2023 FINKI-191257. All rights reserved.
//

import Foundation


import Foundation

// MARK: - WelcomeElement
struct Element: Codable {
    let productName: String
    let productCategory: ProductCategory
    let id: Int
    let productImage: String
    let productPrice, productRating: Int
    let productDescription: String
}

// MARK: - ProductCategory
struct ProductCategory: Codable {
    let id: Int
    let categotyName: String
}

