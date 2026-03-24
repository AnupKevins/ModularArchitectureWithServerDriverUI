//
//  ServerDrivenUIApp.swift
//  ServerDrivenUI
//
//  Created by Anup Sahu on 02/03/26.
//

import SwiftUI
import CoreData

// TODO

//Dependency Direction
//Presentation Layer -> Domain Layer <- Data Repositories Layer
//
//Presentation Layer (MVVM) = ViewModels(Presenters) + Views(UI)
//
//Domain Layer = Entities + Use Cases + Repositories Interfaces
//
//Data Repositories Layer = Repositories Implementations + API(Network) + Persistence DB

import CoreModule
@main
struct ServerDrivenUIApp: App {
    private let appCoordinator: AppCoordinator
    private let appRouter: AppRouter<AppRoute>
    
    init() {
        appRouter = AppRouter<AppRoute>()
        let appDependency = AppDependency(environment: .dev, router: appRouter)
        
        self.appCoordinator = appDependency.appCoordinator
    }
    
    var body: some Scene {
        WindowGroup {
            AppRootView(coordinator: appCoordinator, appRouter: appRouter)
        }
    }
}
