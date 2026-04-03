//
//  AppRootView.swift
//  ServerDrivenUI
//
//  Created by Anup Sahu on 04/03/26.
//

import SwiftUI
import CoreModule
import FeatureHome

struct AppRootView: View {
    
    @State private var appRouter: AppRouter<AppRoute>
    private let appCoordinator: AppCoordinator
    
    init(coordinator: AppCoordinator, appRouter: AppRouter<AppRoute>) {
        self.appCoordinator = coordinator
        self._appRouter = State(wrappedValue: appRouter)
    }
    
    var body: some View {
        NavigationStack(path: $appRouter.path) {
            appCoordinator.start(
                route: .homeRoute(.home)
            )
            .navigationDestination(for: AppRoute.self) { route in
                appCoordinator.start(
                    route: route
                )
            }
        }
        .sheet(
            item: $appRouter.presentedSheet,
            onDismiss: {
                // Swiftui set binding to nil
                // so $appRouter.presentedSheet = nil  // already done
            print("@@@ Sheet Dismiss")
        }) { sheet in
            appCoordinator.start(route: sheet.route)
        }
        .environment(\.homeNavigator, HomeFeatureNavigatorImpl(router: appRouter))
    }
}
