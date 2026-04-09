//
//  PaymentSDKImpl.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 01/04/26.
//

import Foundation

final class PaymentSDKImpl: PaymentSDK {
    
    private let paymentProcessor: PaymentProcessor
    private let idempotencyStore: IdempotencyStore
    private let selector: PaymentMethodSelector
    private let userProvider: UserProvider
    
    init(
        paymentProcessor: PaymentProcessor,
        idempotencyStore: IdempotencyStore = IdempotencyStore(),
        selector: PaymentMethodSelector,
        userProvider: UserProvider
    ) {
        self.paymentProcessor = paymentProcessor
        self.idempotencyStore = idempotencyStore
        self.selector = selector
        self.userProvider = userProvider
    }
    
    func startPayment(amount: Double) async throws -> PaymentResponse {
        
        // ✅ 1. Validate input
        guard amount > 0 else {
            throw PaymentSDKError.invalidInput
        }
        
        // ✅ 2. Generate idempotency key internally
        let idempotencyKey = UUID().uuidString
        
        let isNew = await idempotencyStore.check(
            key: idempotencyKey
        )
        
        guard isNew else {
            throw PaymentSDKError.duplicateRequest
        }
        
        // ✅ 3. Show UI → get user selection
        let selection = try await selector.selectPaymentMethod()
        
        // ✅ 4. Build request internally
        let request = PaymentRequestModel(
            senderId: userProvider.userId,
            amount: amount,
            paymentMethod: selection.method,
            details: selection.details,
            idempotencyKey: idempotencyKey
        )
        do {
            return try await paymentProcessor.process(request: request)
        } catch {
            throw PaymentSDKError.failed
        }
    }
}
