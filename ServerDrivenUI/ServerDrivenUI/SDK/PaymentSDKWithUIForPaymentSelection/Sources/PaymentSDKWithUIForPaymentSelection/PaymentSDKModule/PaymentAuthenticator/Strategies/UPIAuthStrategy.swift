//
//  UPIAuthStrategy.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 14/04/26.
//

final class UPIAuthStrategy: PaymentAuthStrategy {
    
    func authenticate(paymentSelection: PaymentSelection) async throws -> AuthResult {
        
        // 🔥 Simulate app switch
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // In real:
        // → trigger intent
        // → wait for callback / deeplink
        
        return AuthResult(isSuccess: true)
    }
}
