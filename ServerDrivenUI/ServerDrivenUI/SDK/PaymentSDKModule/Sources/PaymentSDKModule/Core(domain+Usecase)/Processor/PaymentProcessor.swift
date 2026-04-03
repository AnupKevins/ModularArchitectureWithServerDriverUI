//
//  PaymentProcessor.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 31/03/26.
//
// “Yes, we can introduce a protocol for PaymentProcessor, but it’s not necessary here since there’s only one implementation and no need for abstraction. Overusing protocols can add unnecessary complexity.”

// For test cases
// “We mock dependencies at the boundary of the system, so mocking the repository is sufficient without introducing unnecessary protocols.”
/*
View (@MainActor)
↓
ViewModel (@MainActor)
↓
UseCase (Sendable)
↓
Repository (Sendable)
↓
Network
*/
// Why PaymentProcessor is not actor
//Because PaymentProcessor is stateless ✅ and it has no mutable shared state
//👉 Shared ≠ dangerous
//👉 Mutable shared state = dangerous
final class PaymentProcessor: Sendable {
    
    // Foe enum
    // private let repository: PaymentRepository
    
    // For Strategy pattern Payment handler registry
    private let registry: PaymentHandlerRegistry
    
    init(registry: PaymentHandlerRegistry) {
        self.registry = registry
    }
    
    func process(request: PaymentRequestModel) async throws -> PaymentResponse {
        
        guard let handler = registry.getPaymentHandler(
            for: request.paymentMethod) else {
            throw PaymentSDKError.failed
        }
        
        return try await handler.handlePayment(request: request)
    }
}
