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
    
    public typealias Route = ProductRoute

    private let productCoordinator: ProductCoordinator
    
    public init(productCoordinator: ProductCoordinator) {
        self.productCoordinator = productCoordinator
    }
    
    public func resolve(route: ProductRoute) -> AnyView? {
        switch route {
            case .productList:
                productCoordinator.build(route: .productList)
        }
    }
}
