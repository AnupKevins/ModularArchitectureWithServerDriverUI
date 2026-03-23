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
    
    private let resolvers: [AppRoute: Resolver]
    init(
        resolvers: [AppRoute: Resolver]
    ) {
        self.resolvers = resolvers
        // 🔥 Register once here
        ServerDrivenEngineViewRegister.registerDefaults()
    }
    
    func start(route: AppRoute) -> AnyView {
        print("@@@ route: \(route)")
        
        if let resolver = resolvers[route] {
            print("@@@ Resolver: \(resolver)")
            if let view = resolver.resolve(route: route) {
                print("@@@ view: \(view)")
                return view
            }
        }
        
        return AnyView(Text("No View for this route"))
    }
}
