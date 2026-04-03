//
//  HomeFeatureNavigator.swift
//  ServerDrivenUI
//
//  Created by Anup Sahu on 24/03/26.
//

import Foundation
import FeatureHome
import FeatureProducts
import FeatureVoiceOver
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
    
    func openVoiceOver() {
        router.push(route: .voiceOverRoute(.voiceOver))
    }
    
    func openPayment() {
        router.presentSheet(.homeRoute(.paymentScreen))
    }
}
