//
//  ProductResponseDTO.swift
//  FeatureProducts
//
//  Created by Anup Sahu on 04/03/26.
//

import Foundation

public struct ProductResponseDTO: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let image: String
    let rating: Rating
}

public enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

// MARK: - Rating
public struct Rating: Codable {
    let rate: Double
    let count: Int
}
