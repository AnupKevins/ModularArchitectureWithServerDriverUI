//
//  Models.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 21/04/26.
//

struct PaymentSelection: Sendable {
    let methodType: String
    let details: PaymentDetails
}
