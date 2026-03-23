// The Swift Programming Language
// https://docs.swift.org/swift-book

import ServerDrivenModelsKit
import CoreModule

protocol HomeRepository {
    func fetchHome() async throws -> [HomeComponentEntity]
    func fetchServerDrivenHome() async throws -> [ComponentConfigDTO]
}

final class HomeRepositoryImpl: HomeRepository {
    private let apiClient: APIClient
    private let homeRequest: HomeRequest
    private let homeMapper: HomeMapper
    
    init(
        apiClient: APIClient,
        homeRequest: HomeRequest = HomeRequest(),
        homeMapper: HomeMapper = HomeMapperImpl()
    ) {
        self.apiClient = apiClient
        self.homeRequest = homeRequest
        self.homeMapper = homeMapper
    }
    
    public func fetchHome() async throws -> [HomeComponentEntity] {
        
        let serverPageResponseDTO = try await apiClient.request(homeRequest)
        print("serverPageResponseDTO", serverPageResponseDTO)
        
        return serverPageResponseDTO.components.map { homeMapper.map(dto: $0) }
    }
    
    func fetchServerDrivenHome() async throws -> [ComponentConfigDTO] {
        let serverPageResponseDTO = try await apiClient.request(homeRequest)
        print("serverPageResponseDTO", serverPageResponseDTO)
        
        return serverPageResponseDTO.components
    }
}
