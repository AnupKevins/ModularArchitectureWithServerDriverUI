// The Swift Programming Language
// https://docs.swift.org/swift-book

import CoreModule

public protocol ProductRepository {
    func fetchProduct() async throws -> [Product] // Repository should return Domain model, not DTO.
    // Network → DTO
//    Repository → maps DTO → Domain
//    UseCase → returns Domain
//    ViewModel → maps Domain → UI Model
}

final class ProductRepositoryImpl: ProductRepository {
    private let apiClient: APIClient
    
    private let mapper: ProductMapper
    
    private let productRequest: ProductRequest
    
    init(
        apiClient: APIClient,
        mapper: ProductMapper = ProductMapperImpl(),
        productRequest: ProductRequest = ProductRequest()
    ) {
        self.apiClient = apiClient
        self.mapper = mapper
        self.productRequest = productRequest
    }
    
    public func fetchProduct() async throws -> [Product] {
        
        let dtoList: [ProductResponseDTO] = try await apiClient.request(productRequest)
        print("dto", dtoList)
        
        let product = dtoList.map { mapper.map(dto: $0) }
        
        return product
    }
}
