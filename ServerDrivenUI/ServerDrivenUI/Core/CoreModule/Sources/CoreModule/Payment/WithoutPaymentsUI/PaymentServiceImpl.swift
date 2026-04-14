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
