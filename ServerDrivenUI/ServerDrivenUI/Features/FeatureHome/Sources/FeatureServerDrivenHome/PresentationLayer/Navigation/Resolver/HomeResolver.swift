//
//  HomeResolver.swift
//  FeatureHome
//
//  Created by Anup Sahu on 23/03/26.
//

import Foundation
import CoreModule
import SwiftUI

public final class HomeResolver: Resolver {
    
    private let coordinator: HomeCoordinator
    
    public init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    public func resolve(route: any Hashable) -> AnyView? {
        
        guard let route = route as? ServerDrivenHomeRoute else { return nil }
        
        switch route {
            case .home:
                return coordinator.build(route: route)
        }
    }
}
