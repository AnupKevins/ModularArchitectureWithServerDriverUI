//
//  PaymentMethodSelector.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 08/04/26.
//

//protocol PaymentMethodSelector: Sendable {
//    // “The method is async because it waits for user interaction, which is inherently asynchronous.”
//    func selectPaymentMethod() async throws -> PaymentSelection
//}
/*
startPayment()
↓
SDK shows UI (bottom sheet)
↓
User taps UPI / Card / Wallet
↓
SDK returns selection
*/
//👉 This is not immediate → it waits for user action
