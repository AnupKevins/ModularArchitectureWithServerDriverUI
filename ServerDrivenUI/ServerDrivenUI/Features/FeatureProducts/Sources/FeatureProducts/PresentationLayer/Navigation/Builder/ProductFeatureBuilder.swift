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
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    @MainActor func makeProductView() -> AnyView {
        
        // call vm and Product screen
        let repository = ProductRepositoryImpl(apiClient: apiClient)
        
        let useCase = FetchProductUseCaseImpl(repository: repository)
        
        let viewModel = ProductViewModelImpl(useCase: useCase)
        
        let view = ProductView(viewModel: viewModel)
        
        return AnyView(view)
    }
}
