//
//  PaymentResult.swift
//  CoreModule
//
//  Created by Anup Sahu on 07/04/26.
//

public struct PaymentResult {
    public let transactionId: String
    public let status: String
    
    public init(transactionId: String, status: String) {
        self.transactionId = transactionId
        self.status = status
    }
}
