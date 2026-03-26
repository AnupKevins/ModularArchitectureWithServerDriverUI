//
//  HomeViewModel.swift
//  FeatureHome
//
//  Created by Anup Sahu on 03/03/26.
//

import Foundation
import Combine
import Observation

@MainActor
protocol ProductViewModel: AnyObject {
    var products: [Product] { get }
    var isLoading: Bool { get }
    var error: Error? { get }
    
    func fetchProducts() async
    func deleteProduct(_ product: Product)
}

@MainActor
@Observable
final class ProductViewModelImpl: ProductViewModel {
    var products: [Product] = []
    var isLoading: Bool = false
    var error: Error?
    
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
            self.error = error
        }
        
    }
    
    func deleteProduct(_ product: Product) {
        products.removeAll(where: { $0.id == product.id })
    }
}
