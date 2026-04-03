//
//  PaymentRequest.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 30/03/26.
//

import Foundation

public struct PaymentRequestModel {
    
    public let senderId: String
    public let amount: Double
    // public let paymentType: PaymentType
    public let paymentMethod: PaymentMethod
    public let details: PaymentDetails
    public let idempotencyKey: String // a unique identifier for a request to ensure it is processed only once
    
   /* In real systems:
    
    Network retry happens
    User taps button multiple times
    App crashes and retries
    
    👉 Without idempotency:
    
    User sends ₹1000
    → API called twice
    → ₹2000 deducted ❌
    ✅ With idempotency key
Request:
    amount = 1000
    idempotencyKey = "abc123"
Flow:
    First request → processed ✅
    Second request (same key) → ignored / same response returned ✅*/
    
    public init(senderId: String, amount: Double, paymentMethod: PaymentMethod, details: PaymentDetails, idempotencyKey: String) {
        self.senderId = senderId
        self.amount = amount
        self.paymentMethod = paymentMethod
        self.details = details
        self.idempotencyKey = idempotencyKey
    }
}
