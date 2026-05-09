//
//  PaymentResponse.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 06/05/26.
//

public struct PaymentResponse {
    public let transactionId: String
    public let status: PaymentStatus
    
    init(transactionId: String, status: PaymentStatus) {
        self.transactionId = transactionId
        self.status = status
    }
}
