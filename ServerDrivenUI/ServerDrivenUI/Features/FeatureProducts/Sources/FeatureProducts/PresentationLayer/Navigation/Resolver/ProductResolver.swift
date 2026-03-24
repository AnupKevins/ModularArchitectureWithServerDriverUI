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
    
    public func resolve(route: any Hashable) -> AnyView? {
        
        guard let route = route as? ProductRoute else { return nil }
        
        switch route {
            case .productList:
               return productCoordinator.build(route: .productList)
        }
    }
}
