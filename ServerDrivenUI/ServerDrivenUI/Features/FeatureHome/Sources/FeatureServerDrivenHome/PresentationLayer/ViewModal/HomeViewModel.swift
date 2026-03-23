//
//  HomeViewModel.swift
//  FeatureHome
//
//  Created by Anup Sahu on 03/03/26.
//

import Foundation
import ServerDrivenModelsKit
import CoreModule
import Observation

@MainActor
protocol HomeViewModel {
    var components: [ComponentConfigDTO] { get }
    var isLoading: Bool { get }
    func fetchHomeComponents() async
}

@MainActor
@Observable final class HomeViewModelImpl: HomeViewModel {
    var components: [ComponentConfigDTO] = []
    var isLoading: Bool = false
    
    private let useCase: FetchHomeUseCase
   // private let router: AppRouter
    
    init(useCase: FetchHomeUseCase) {
        self.useCase = useCase
    }
    
//    func navigateToProducts() {
//        router.navigateToProducts()
//    }
    
    func fetchHomeComponents() async {
        
        guard components.isEmpty else { return }
        
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            let componentConfigDTO = try await useCase.executeServerDrivenHome()
            print("componentConfigDTO \(componentConfigDTO)")
            
            components = componentConfigDTO
            
        } catch {
            print("error", error)
        }
        
    }
}
