//
//  CustomPaymentDetail.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 06/04/26.
//

public struct CustomPaymentDetail: PaymentDetails {
    
    private let payload: [String: Any]
    
    public init(payload: [String : Any]) {
        self.payload = payload
    }
    
    public func toDictionary() -> [String : Any] {
        return payload
    }
}
