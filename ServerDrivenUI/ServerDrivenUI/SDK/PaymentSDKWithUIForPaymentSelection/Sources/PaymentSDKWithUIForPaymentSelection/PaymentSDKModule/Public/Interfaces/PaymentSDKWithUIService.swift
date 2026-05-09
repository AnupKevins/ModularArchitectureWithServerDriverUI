//
//  PaymentSDKUIService.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 21/04/26.
//

@MainActor
public protocol PaymentSDKUIService: Sendable {
    func startPayment(amount: Double) async throws -> PaymentResponse
}
