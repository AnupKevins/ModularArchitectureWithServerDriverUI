//
//  HomeFeatureBuilder.swift
//  FeatureHome
//
//  Created by Anup Sahu on 03/03/26.
//

import SwiftUI
import CoreModule

protocol ProductFeatureBuilder {
    @MainActor func makeProductView() -> AnyView
}

final class ProductFeatureBuilderImpl: ProductFeatureBuilder {
    private let apiClient: APIClient
    private let router: AppRouter<AppRoute>
    
    init(apiClient: APIClient, router: AppRouter<AppRoute>) {
        self.apiClient = apiClient
        self.router = router
    }
    
    @MainActor func makeProductView() -> AnyView {
        
        // call vm and Product screen
        let repository = ProductRepositoryImpl(apiClient: apiClient)
        
        let useCase = FetchProductUseCaseImpl(repository: repository)
        
        let viewModel = ProductViewModel(useCase: useCase)
        
        let view = ProductView(viewModel: viewModel)
        
        return AnyView(view)
    }
}
