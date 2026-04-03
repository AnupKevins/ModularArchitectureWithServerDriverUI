//
//  CreatePaymentAPIRequest.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 31/03/26.
//

import Foundation

struct PaymentAPIRequest: APIRequest {
    
    typealias Response = PaymentResponseDTO
    
    let request: PaymentRequestModel
    
    var path: String { "/payments" }
    var method: String { "POST" }
    
//    Content-Type → tells server how to read body
//    Idempotency-Key → prevents duplicate transactions
    var headers: [String : String] {
        [
            "Content-Type": "application/json",
            "Idempotency-Key": request.idempotencyKey
        ]
    }
    
    var body: Data? {
        
        var payload: [String: Any] = [
            "amount": request.amount,
            "senderId": request.senderId,
            "type": request.paymentMethod.type
            // For Enum
            // "type": mapType(request.paymentType)
        ]
        
        payload.merge(request.details.toDictionary()) { _, new in new }
        
        let data = try? JSONSerialization.data(withJSONObject: payload, options: [.prettyPrinted])
        
        print("payment api request data:", data)
        return data
        // var dict1 = ["name": "Old"]
        // let dict2 = ["name": "New"]
        
        // dict1.merge(dict2) { _, new in new } “If key exists → use new value”
        // Result : ["name": "New"]
    }
    // for Enum
//    private func mapType(_ type: PaymentType) -> String {
//        switch type {
//            case .upi:
//                return "UPI"
//            case .neft:
//                return "NEFT"
//            case .rtgs:
//                return "RTGS"
//        }
//    }
}
