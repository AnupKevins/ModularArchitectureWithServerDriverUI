//
//  ProductResolver.swift
//  FeatureProducts
//
//  Created by Anup Sahu on 23/03/26.
//

import Foundation
import CoreModule
import SwiftUI

public final class ProductResolver: Resolver {

    private let productCoordinator: ProductCoordinator
    
    public init(productCoordinator: ProductCoordinator) {
        self.productCoordinator = productCoordinator
    }
    
    public func resolve(route: AppRoute) -> AnyView? {
        switch route {
            case .productListRoute:
                productCoordinator.build(route: .productList)
            default:
                nil
        }
    }
}
