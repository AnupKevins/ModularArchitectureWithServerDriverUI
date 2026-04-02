//
//  PaymentProcessor.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 31/03/26.
//
// “Yes, we can introduce a protocol for PaymentProcessor, but it’s not necessary here since there’s only one implementation and no need for abstraction. Overusing protocols can add unnecessary complexity.”

// For test cases
// “We mock dependencies at the boundary of the system, so mocking the repository is sufficient without introducing unnecessary protocols.”
final class PaymentProcessor {
    
    private let repository: PaymentRepository
    
    init(repository: PaymentRepository) {
        self.repository = repository
    }
    
    func process(request: PaymentRequestModel) async throws -> PaymentResponse {
        
        return try await repository.makePayment(request: request)
    }
}
