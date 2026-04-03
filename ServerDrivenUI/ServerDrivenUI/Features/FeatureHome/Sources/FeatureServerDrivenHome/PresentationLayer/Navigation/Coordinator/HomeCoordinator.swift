//
//  HomeCoordinator.swift
//  FeatureHome
//
//  Created by Anup Sahu on 03/03/26.
//

import SwiftUI
import CoreModule

@MainActor
public protocol HomeCoordinator {
    func build(route: ServerDrivenHomeRoute) -> AnyView
}

public struct HomeCoordinatorImpl: HomeCoordinator {
    
    private let homeBuilder: HomeFeatureBuilder
    
    init(homeBuilder: HomeFeatureBuilder) {
        self.homeBuilder = homeBuilder
    }
    
    public func build(route: ServerDrivenHomeRoute) -> AnyView {
        switch route {
            case .home:
                return homeBuilder.makeHome()
            case .paymentScreen:
                return homeBuilder.makePayment()
        }
    }
    
}

