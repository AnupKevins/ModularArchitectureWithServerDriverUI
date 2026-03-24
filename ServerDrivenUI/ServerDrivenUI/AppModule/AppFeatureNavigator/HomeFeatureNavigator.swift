//
//  HomeFeatureNavigator.swift
//  ServerDrivenUI
//
//  Created by Anup Sahu on 24/03/26.
//

import Foundation
import FeatureHome
import FeatureProducts
import CoreModule
import Observation

@Observable
final class HomeFeatureNavigatorImpl: HomeNavigator {
    
    private let router: AppRouter<AppRoute>
    
    init(router: AppRouter<AppRoute>) {
        self.router = router
    }
    
    func openProductList() {
        router.push(route: .productListRoute(.productList))
    }
}
