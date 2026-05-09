//
//  PaymentMethodsProvider.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 27/04/26.
//

// Client should enable it based on its backend
// UPI, Card, Wallet, NetBanking, etc.
public protocol PaymentMethodsProvider: Sendable {
    func fetchPaymentOptions() async throws -> [PaymentOption]
}
