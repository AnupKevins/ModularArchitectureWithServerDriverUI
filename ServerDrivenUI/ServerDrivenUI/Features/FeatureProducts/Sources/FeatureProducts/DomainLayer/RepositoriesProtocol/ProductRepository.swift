//
//  ProductRepository.swift
//  FeatureProducts
//
//  Created by Anup Sahu on 24/03/26.
//

public protocol ProductRepository {
    func fetchProduct() async throws -> [Product] // Repository should return Domain model, not DTO.
    // Network → DTO
    //    Repository → maps DTO → Domain
    //    UseCase → returns Domain
    //    ViewModel → maps Domain → UI Model
}
