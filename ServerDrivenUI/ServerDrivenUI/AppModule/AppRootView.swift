//
//  AppRootView.swift
//  ServerDrivenUI
//
//  Created by Anup Sahu on 04/03/26.
//

import SwiftUI
import CoreModule

struct AppRootView: View {
    
    @State private var appRouter: AppRouter<AppRoute>
    private let appCoordinator: AppCoordinator
    
    init(coordinator: AppCoordinator, appRouter: AppRouter<AppRoute>) {
        self.appCoordinator = coordinator
        self._appRouter = State(wrappedValue: appRouter)
    }
    
    var body: some View {
        print("@@@ AppRootView body recomputed")
        return NavigationStack(path: $appRouter.path) {
            print("@@@ AppRootView NavigationStack")
            return appCoordinator.start(
                route: .homeRoute
            )
            .navigationDestination(for: AppRoute.self) { route in
                print("@@@ AppRootView navigationDestination")
               return appCoordinator.start(
                    route: route
                )
            }
            
        }
    }
}
