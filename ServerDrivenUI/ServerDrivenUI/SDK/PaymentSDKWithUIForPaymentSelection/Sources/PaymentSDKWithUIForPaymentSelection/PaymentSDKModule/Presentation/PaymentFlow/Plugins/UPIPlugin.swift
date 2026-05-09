//
//  UPIPlugin.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 21/04/26.
//
//

final class UPIPlugin: PaymentMethodPlugin {
    
    let type = "UPI"
    let displayName = "UPI"
    
    // it check whether type is present
    func canHandle(_ options: PaymentOption) -> Bool {
        options.type == type
    }
    // App Switch
    func handle(option: PaymentOption) async throws -> PaymentSelection {
        let upiId = "user@upi" // simulate
        
        return PaymentSelection(
            methodType: "UPI",
            details: .upi(upiId: upiId)
        )
    }
}
