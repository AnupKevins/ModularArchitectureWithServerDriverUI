//
//  PaymentMethodPlugin.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 21/04/26.
//

protocol PaymentMethodPlugin: Sendable {
    var type: String { get }
    
    var displayName: String { get }
    
    // “Can this plugin handle this selected payment option?”
    func canHandle(_ options: PaymentOption) -> Bool
    
    func handle(option: PaymentOption) async throws -> PaymentSelection
    /// plugin is acting as paymentAuthenticator
    // 🔥 handle solve
    //   Different payment methods behave differently:
    //    UPI     → app switch
    //    Wallet  → OTP
    //    Card    → 3DS / WebView
}
