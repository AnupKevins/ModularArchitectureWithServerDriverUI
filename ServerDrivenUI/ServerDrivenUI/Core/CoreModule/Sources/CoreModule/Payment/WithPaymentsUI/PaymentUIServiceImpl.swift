//
//  PaymentUIServiceImpl.swift
//  CoreModule
//
//  Created by Anup Sahu on 13/04/26.
//

import PaymentSDKWithUIForPaymentSelection

public final class PaymentUIServiceImpl: PaymentUIService {
    
    private let paymentSDK: PaymentSDKWithUI
    
    public init(paymentSDK: PaymentSDKWithUI) {
        self.paymentSDK = paymentSDK
    }
    
    public func pay(amount: Double) async throws -> PaymentResult {
        
        // ✅ SDK handles:
        // - userId (via UserProvider)
        // - UI (selector)
        // - method selection
        // - request building
        
        let sdkResponse = try await paymentSDK.startPayment(amount: amount)
        
        return PaymentResult(
            transactionId: sdkResponse.transactionId,
            status: mapStatus(sdkResponse.status)
        )
    }
    
    private func mapStatus(_ status: PaymentStatus) -> String {
        switch status {
            case .success: return "success"
            case .pending: return "pending"
            case .failed: return "failed"
        }
    }
}
