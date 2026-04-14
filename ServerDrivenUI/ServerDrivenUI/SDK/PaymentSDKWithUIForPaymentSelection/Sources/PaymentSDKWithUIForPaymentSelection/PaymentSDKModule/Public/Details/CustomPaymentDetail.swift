//
//  CustomPaymentDetail.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 06/04/26.
//

public struct CustomPaymentDetail: PaymentDetails {
    
    private let payload: [String: JSONValue]
    
    public init(payload: [String : JSONValue]) {
        self.payload = payload
    }
    
    public func toDictionary() -> [String : Any] {
        return payload.mapValues { $0.toAny() }
    }
    
    /*
     let payload: [String: JSONValue] = [
        "name": .string("John"),
        "age": .int(30)
    ]
    
    After mapValues
    
    [
        "name": "John",
        "age": 30
    ]
    */
}
