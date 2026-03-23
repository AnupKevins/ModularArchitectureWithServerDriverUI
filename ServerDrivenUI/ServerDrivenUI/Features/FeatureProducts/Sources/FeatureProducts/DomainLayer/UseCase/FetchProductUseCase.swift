//
//  FetrchHomeUseCase.swift
//  FeatureHome
//
//  Created by Anup Sahu on 03/03/26.
//
import Foundation

protocol FetchProductUseCase: Sendable {
    func execute() async throws -> [Product]
}

public final class FetchProductUseCaseImpl: FetchProductUseCase, @unchecked Sendable {
    
    private let repository: ProductRepository
    
    init(repository: ProductRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [Product] {
        try await repository.fetchProduct()
    }
}
