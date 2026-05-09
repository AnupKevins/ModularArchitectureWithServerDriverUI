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

enum PaymentDetails: Sendable {
    case wallet(walletId: String, authToken: String)
    case upi(upiId: String)
    case card(cardNumber: String, cvv: String, expiry: String)
    case neft(ifsc: String, accountNumber: String)
}

extension PaymentDetails {
    
    func toDictionary() -> [String: Any] {
        switch self {
            case .wallet(let walletId, let authToken):
                return [
                    "walletId": walletId,
                    "authToken": authToken
                ]
                
            case .upi(upiId: let upi):
                return [
                    "upiId": upi
                ]
                
            case .card(let cardNumber, let cvv, let expiry):
                return [
                    "cardNumber": cardNumber,
                    "cvv": cvv,
                    "expiry": expiry
                ]
            case .neft(let ifsc, let accountNumber):
                return [
                    "ifsc": ifsc,
                    "accountNumber": accountNumber
                ]
        }
    }
}
