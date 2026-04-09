//
//  UPIPaymentDetails.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 06/04/26.
//

public struct UPIPaymentDetails: PaymentDetails {
    public let upiId: String
    public let upiName: String
    
    public init(upiId: String, upiName: String) {
        self.upiId = upiId
        self.upiName = upiName
    }
    
    public func toDictionary() -> [String : Any] {
        [
            "upiId": upiId,
            "upiName": upiName
        ]
    }
}
