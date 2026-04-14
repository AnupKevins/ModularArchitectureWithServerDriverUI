//
//  HomeFeatureBuilder.swift
//  FeatureHome
//
//  Created by Anup Sahu on 03/03/26.
//

import SwiftUI
import CoreModule

@MainActor
protocol HomeFeatureBuilder {
    
    func makeHome() -> AnyView
    func makePayment() -> AnyView
}

final class HomeFeatureBuilderImpl: HomeFeatureBuilder {
    private let apiClient: APIClient
    private let paymentService: PaymentService
    private let paymentUIService: PaymentUIService
    
    init(apiClient: APIClient, paymentService: PaymentService, paymentUIService: PaymentUIService) {
        self.apiClient = apiClient
        self.paymentService = paymentService
        self.paymentUIService = paymentUIService
    }
    
    func makeHome() -> AnyView {
        
        let repository = HomeRepositoryImpl(apiClient: apiClient)
        // call vm and homescreen
        let useCase = FetchHomeUseCaseImpl(repository: repository)
        
        let viewModel = HomeViewModelImpl(useCase: useCase)
        
        let homeView = HomeView(viewModel: viewModel)
        
        return AnyView(homeView)
    }
    
    func makePayment() -> AnyView {
                
        let viewModel = HomePaymentViewModelImpl(paymentSDKService: paymentService, paymentUIService: paymentUIService)
        
        let paymentView = HomePaymentView(viewModel: viewModel)
        
        return AnyView(paymentView)
    }
}
