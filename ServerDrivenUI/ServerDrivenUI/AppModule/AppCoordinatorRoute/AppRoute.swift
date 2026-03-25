//
//  AppRoute.swift
//  ServerDrivenUI
//
//  Created by Anup Sahu on 24/03/26.
//

import FeatureHome
import FeatureProducts
import FeatureVoiceOver

public enum AppRoute: Hashable {
    case homeRoute(ServerDrivenHomeRoute)
    case productListRoute(ProductRoute)
    case voiceOverRoute(VoiceOverRoute)
    
}

extension AppRoute {
    
    var featureRoute: any Hashable {
        
        switch self {
            case .homeRoute(let route):
                return route
            case .productListRoute(let route):
                return route
            case .voiceOverRoute(let route):
                return route
        }
    }
}
