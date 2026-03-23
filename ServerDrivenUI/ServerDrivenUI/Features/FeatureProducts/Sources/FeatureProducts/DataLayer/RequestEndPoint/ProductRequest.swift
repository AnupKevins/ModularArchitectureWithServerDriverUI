//
//  ProductRequest.swift
//  FeatureProducts
//
//  Created by Anup Sahu on 20/03/26.
//

import Foundation
import CoreModule

struct ProductRequest: APIRequest {
    typealias Response = [ProductResponseDTO]
    
    var path: String { "products" }
    
    var httpMethod: HttpMethod { .get }
}

