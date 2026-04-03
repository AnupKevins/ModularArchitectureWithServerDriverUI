//
//  PaymentResponse.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 30/03/26.
//

public struct PaymentResponse {
    public let transactionId: String
    public let status: PaymentStatus
    
    public init(transactionId: String, status: PaymentStatus) {
        self.transactionId = transactionId
        self.status = status 
    }
}
