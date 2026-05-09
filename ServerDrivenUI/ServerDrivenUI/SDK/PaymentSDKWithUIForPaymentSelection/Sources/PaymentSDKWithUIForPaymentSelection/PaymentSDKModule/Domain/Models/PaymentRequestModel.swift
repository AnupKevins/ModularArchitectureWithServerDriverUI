//
//  PaymentRequestModel.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 10/05/26.
//

struct PaymentRequestModel {
    let senderId: String
    let amount: Double
    let paymentMethod: String
    let details: PaymentDetails
    let idempotencyKey: String
    
    /*👉 Without idempotency:
     
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
}
