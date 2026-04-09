//
//  CustomPaymentMethod.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 06/04/26.
//

public struct CustomPaymentMethod: PaymentMethod {
    
    public let type: String
    
    public init(type: String) {
        self.type = type
    }
}
