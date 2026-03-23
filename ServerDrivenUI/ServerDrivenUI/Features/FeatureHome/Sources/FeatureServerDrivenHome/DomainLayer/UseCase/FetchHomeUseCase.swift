//
//  FetrchHomeUseCase.swift
//  FeatureHome
//
//  Created by Anup Sahu on 03/03/26.
//
import Foundation
import ServerDrivenModelsKit

protocol FetchHomeUseCase: Sendable {
    func execute() async throws -> [HomeComponentEntity]
    func executeServerDrivenHome() async throws -> [ComponentConfigDTO]
}

final class FetchHomeUseCaseImpl: FetchHomeUseCase, @unchecked Sendable {
    
    private let repository: HomeRepository
    
    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [HomeComponentEntity] {
        try await repository.fetchHome()
    }
    
    func executeServerDrivenHome() async throws -> [ComponentConfigDTO] {
        try await repository.fetchServerDrivenHome()
    }
}
