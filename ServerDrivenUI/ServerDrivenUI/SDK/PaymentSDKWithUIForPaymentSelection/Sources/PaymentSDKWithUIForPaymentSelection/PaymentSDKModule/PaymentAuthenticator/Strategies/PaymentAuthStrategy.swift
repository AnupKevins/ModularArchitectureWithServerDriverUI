//
//  PaymentAuthStrategy.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 14/04/26.
//

protocol PaymentAuthStrategy {
    func authenticate(paymentSelection: PaymentSelection) async throws -> AuthResult
}
