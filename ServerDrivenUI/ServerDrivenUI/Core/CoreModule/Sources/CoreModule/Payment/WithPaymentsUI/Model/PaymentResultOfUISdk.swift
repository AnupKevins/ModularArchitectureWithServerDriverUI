//
//  PaymentResult.swift
//  CoreModule
//
//  Created by Anup Sahu on 06/05/26.
//

public struct PaymentResultOfUISdk {
    public let transactionId: String
    public let status: String
    
    public init(transactionId: String, status: String) {
        self.transactionId = transactionId
        self.status = status
    }
}
