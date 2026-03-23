//
//  HomeFeatureBuilder.swift
//  FeatureHome
//
//  Created by Anup Sahu on 03/03/26.
//

import SwiftUI
import CoreModule

protocol HomeFeatureBuilder {
    @MainActor
    func makeHome() -> AnyView
}

final class HomeFeatureBuilderImpl: HomeFeatureBuilder {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    @MainActor func makeHome() -> AnyView {
        
        let repository = HomeRepositoryImpl(apiClient: apiClient)
        // call vm and homescreen
        let useCase = FetchHomeUseCaseImpl(repository: repository)
        
        let viewModel = HomeViewModelImpl(useCase: useCase)
        
        let homeView = HomeView(viewModel: viewModel)
        
        return AnyView(homeView)
    }
}
