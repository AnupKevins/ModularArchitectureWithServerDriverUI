//
//  AppCoordinator.swift
//  ServerDrivenUI
//
//  Created by Anup Sahu on 03/03/26.
//

import Foundation
import SwiftUI
import CoreModule
import ServerDrivenEngine

protocol AppCoordinator {
   
    func start(route: AppRoute) -> AnyView
}

final class AppCoordinatorImpl: AppCoordinator {
    
    private let resolver: [Resolver]
    
    init(
       // appDependency: AppDependency,
        resolver: [Resolver]
    ) {
        //self.appDependency = appDependency
        self.resolver = resolver
        // 🔥 Register once here
        ServerDrivenEngineViewRegister.registerDefaults()
    }
    
    func start(route: AppRoute) -> AnyView {
//        switch route {
//            case .homeRoute:
//                appDependency.homeCoordinator.build(route: .home)
//            case .productListRoute:
//                appDependency.productCoordinator.build(route: .productList)
//        }
        
        for resolver in resolver {
            print("@@@ route: \(route)")
            print("@@@ Resolver: \(resolver)")
            if let view = resolver.resolve(route: route) {
                return view
            }
        }
        
        return AnyView(Text("No View for this route"))
    }
}
