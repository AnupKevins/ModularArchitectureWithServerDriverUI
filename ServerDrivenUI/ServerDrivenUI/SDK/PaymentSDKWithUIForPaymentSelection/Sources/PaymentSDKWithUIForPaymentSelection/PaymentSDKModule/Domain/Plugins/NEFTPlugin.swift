//
//  NEFTPlugin.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 22/04/26.
//

final class NEFTPlugin: PaymentMethodPlugin {
    
    let type = "NEFT"
    let displayName = "NEFT"
    
    func canHandle(_ options: PaymentOption) -> Bool {
        options.type == type
    }
    
    func handle(option: PaymentOption) async throws -> PaymentSelection {
        
        return PaymentSelection(
            methodType: "NEFT",
            details: .neft(
                ifsc: "HDFC0001234",
                accountNumber: "1234567890"
            )
        )
    }
}
