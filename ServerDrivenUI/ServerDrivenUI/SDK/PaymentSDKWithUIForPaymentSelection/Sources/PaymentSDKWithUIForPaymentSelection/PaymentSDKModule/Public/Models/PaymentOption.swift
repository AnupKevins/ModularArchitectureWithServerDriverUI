//
//  PaymentOption.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 06/05/26.
//

public struct PaymentOption: Sendable {
    let title: String
    let type: String
    
    public init(title: String, type: String) {
        self.title = title
        self.type = type
    }
}
