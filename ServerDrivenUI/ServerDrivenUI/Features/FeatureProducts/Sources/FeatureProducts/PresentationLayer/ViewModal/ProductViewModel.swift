//
//  HomeViewModel.swift
//  FeatureHome
//
//  Created by Anup Sahu on 03/03/26.
//

import Foundation
import Combine
import ServerDrivenModelsKit

@MainActor
public final class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    
    private let useCase: FetchProductUseCase
    
    init(useCase: FetchProductUseCase) {
        self.useCase = useCase
    }
    
    public func fetchProducts() async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            let products = try await useCase.execute()
            self.products = products
            
        } catch {
            print("error", error)
        }
        
    }
    
    func deleteProduct(_ product: Product) {
        products.removeAll { $0.id == product.id }
    }
}
