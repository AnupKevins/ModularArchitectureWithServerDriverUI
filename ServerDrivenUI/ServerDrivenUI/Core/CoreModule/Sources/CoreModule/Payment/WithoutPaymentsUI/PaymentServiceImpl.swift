//
//  PaymentServiceImpl.swift
//  CoreModule
//
//  Created by Anup Sahu on 02/04/26.
//
/// CoreModule → SDK ❌ (wrong direction)
/// Feature → Core → App → SDK
/// “CoreModule should only define abstractions. The implementation that depends on SDK belongs to the composition root (App layer), not Core.”
import PaymentSDKModule /// this is wrong direction, CoreModule should not depend on SDK, but for the sake of this example, we are doing it to show how to implement the service. In real scenario, we should define an abstraction in CoreModule and implement it in App layer which depends on SDK.
import Foundation

public final class PaymentServiceImpl: PaymentService {
    
    private let paymentSDK: PaymentSDK
    
    public init(paymentSDK: PaymentSDK) {
        self.paymentSDK = paymentSDK
    }
    
    public func pay(input: PaymentInput) async throws -> PaymentResult {
        
        let mapping = input.instrument.toSDK()
        
        let request = PaymentRequestModel(
            senderId: input.senderId,
            amount: input.amount,
            paymentMethod: mapping.method,
            details: mapping.details,
            idempotencyKey: UUID().uuidString
        )
        
        // ✅ Response from SDK
        let sdkResponse = try await paymentSDK.pay(request: request)
        
        return PaymentResult(
            transactionId: sdkResponse.transactionId,
            status: mapStatus(sdkResponse.status)
        )
    }
    
    // 🔹 Mapper
    private func mapStatus(_ status: PaymentStatus) -> String {
        switch status {
            case .success: return "success"
            case .pending: return "pending"
            case .failed: return "failed"
        }
    }
}
