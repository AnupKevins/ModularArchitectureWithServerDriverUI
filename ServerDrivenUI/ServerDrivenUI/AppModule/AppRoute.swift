//
//  AppRoute.swift
//  ServerDrivenUI
//
//  Created by Anup Sahu on 24/03/26.
//

import FeatureHome
import FeatureProducts

public enum AppRoute: Hashable {
    case homeRoute(ServerDrivenHomeRoute)
    case productListRoute(ProductRoute)
}

extension AppRoute {
    
    var featureRoute: any Hashable {
        
        switch self {
            case .homeRoute(let route):
                return route
            case .productListRoute(let route):
                return route
        }
    }
}
