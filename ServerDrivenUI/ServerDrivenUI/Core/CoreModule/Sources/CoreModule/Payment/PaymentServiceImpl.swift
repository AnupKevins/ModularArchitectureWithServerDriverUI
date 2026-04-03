//
//  PaymentServiceImpl.swift
//  CoreModule
//
//  Created by Anup Sahu on 02/04/26.
//
import PaymentSDKModule
import Foundation

public final class PaymentServiceImpl: PaymentService {
    
    private let paymentSDK: PaymentSDK
    
    public init(paymentSDK: PaymentSDK) {
        self.paymentSDK = paymentSDK
    }
    
    public func pay(input: PaymentInput) async throws -> PaymentResponse {
        
        let mapping = input.instrument.toSDK()
        
        let request = PaymentRequestModel(
            senderId: input.senderId,
            amount: input.amount,
            paymentMethod: mapping.method,
            details: mapping.details,
            idempotencyKey: UUID().uuidString
        )
            
        return try await paymentSDK.pay(request: request)
    }
}
