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
            "type": request.paymentMethod
        ]
        
        payload.merge(request.details.toDictionary()) { _, new in new }
        
        let data = try? JSONSerialization.data(withJSONObject: payload, options: [.prettyPrinted])
         
        print("payment api request data:", String(data: data ??  Data(), encoding: .utf8))
        return data
    }
}
