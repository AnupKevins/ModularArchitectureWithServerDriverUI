//
//  PaymentAuthenticator.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 14/04/26.
//

protocol PaymentAuthenticator {
    func authenticate(selection: PaymentSelection) async throws -> AuthResult
}
