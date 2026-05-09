import Foundation
final class PaymentSDKImpl: @unchecked Sendable {
    
    private let paymentProcessor: PaymentProcessor
    private let idempotencyStore: IdempotencyStore
    private let userProvider: UserProvider
    
    init(
        paymentProcessor: PaymentProcessor,
        idempotencyStore: IdempotencyStore = IdempotencyStore(),
        userProvider: UserProvider
    ) {
        self.paymentProcessor = paymentProcessor
        self.idempotencyStore = idempotencyStore
        self.userProvider = userProvider
    }
    
    func processPayment(
        amount: Double,
        selection: PaymentSelection,
    ) async throws -> PaymentResponse {
        
        guard amount > 0 else {
            throw PaymentSDKError.invalidInput
        }
        // 🔥 generate internally
        let idempotencyKey = UUID().uuidString
        
        let isNew = await idempotencyStore.check(key: idempotencyKey)
        
        guard isNew else {
            throw PaymentSDKError.duplicateRequest
        }
        
        let request = PaymentRequestModel(
            senderId: userProvider.userId,
            amount: amount,
            paymentMethod: selection.methodType,
            details: selection.details,
            idempotencyKey: idempotencyKey
        )
        
        return try await paymentProcessor.process(request: request)
    }
}
