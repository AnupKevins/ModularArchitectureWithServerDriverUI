//
//  SDKMapping.swift
//  CoreModule
//
//  Created by Anup Sahu on 03/04/26.
//

import PaymentSDKModule

public struct SDKMapping {
    
    public let method: PaymentMethod
    public let details: PaymentDetails
    
    public init(method: PaymentMethod, details: PaymentDetails) {
        self.method = method
        self.details = details
    }
}
