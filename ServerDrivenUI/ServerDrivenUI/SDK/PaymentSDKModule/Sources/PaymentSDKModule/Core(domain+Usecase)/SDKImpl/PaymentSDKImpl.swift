//
//  PaymentSDKImpl.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 01/04/26.
//

final class PaymentSDKImpl: PaymentSDK {
    
    private let paymentProcessor: PaymentProcessor
    private let idempotencyStore: IdempotencyStore
    
    init(
        paymentProcessor: PaymentProcessor,
        idempotencyStore: IdempotencyStore = IdempotencyStore()
    ) {
        self.paymentProcessor = paymentProcessor
        self.idempotencyStore = idempotencyStore
    }
    
    func pay(request: PaymentRequestModel) async throws -> PaymentResponse {
        
        let isNew = await idempotencyStore.check(
            key: request.idempotencyKey
        )
        
        guard isNew else {
            throw PaymentSDKError.duplicateRequest
        }
        
        guard request.amount > 0 else {
            throw PaymentSDKError.invalidInput
        }
        
        do {
            return try await paymentProcessor.process(request: request)
        } catch {
            throw PaymentSDKError.failed
        }
    }
}
