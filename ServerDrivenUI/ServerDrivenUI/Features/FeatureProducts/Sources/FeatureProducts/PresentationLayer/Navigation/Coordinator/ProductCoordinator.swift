//
//  HomeCoordinator.swift
//  FeatureHome
//
//  Created by Anup Sahu on 03/03/26.
//

import SwiftUI
import CoreModule

public protocol ProductCoordinator {
    @MainActor
    func build(route: ProductRoute) -> AnyView
}

final class ProductCoordinatorImpl: ProductCoordinator {
    private let builder: ProductFeatureBuilder
    
    init(builder: ProductFeatureBuilder) {
        self.builder = builder
    }
    
    @MainActor func build(route: ProductRoute) -> AnyView {
        
         switch route {
            case .productList:
                return builder.makeProductView()
        }
        
    }
    
}


