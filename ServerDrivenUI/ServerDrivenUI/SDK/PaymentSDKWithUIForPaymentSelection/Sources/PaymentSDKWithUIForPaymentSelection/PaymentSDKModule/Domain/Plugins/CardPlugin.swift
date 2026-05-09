//
//  CardPlugin.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 22/04/26.
//

final class CardPlugin: PaymentMethodPlugin {
    
    let type = "CARD"
    let displayName = "Card"
    
    // it check whether type is present
    func canHandle(_ options: PaymentOption) -> Bool {
        options.type == type
    }
    
    func handle(option: PaymentOption) async throws -> PaymentSelection {
       
        return PaymentSelection(
            methodType: "CARD",
            details: .card(
                cardNumber: "4111111111111111",
                cvv: "123",
                expiry: "12/28"
            )
        )
    }
}
