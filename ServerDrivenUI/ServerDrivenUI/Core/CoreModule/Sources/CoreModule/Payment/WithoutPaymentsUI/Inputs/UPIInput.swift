//
//  UPIInput.swift
//  CoreModule
//
//  Created by Anup Sahu on 02/04/26.
//
import PaymentSDKModule

public struct UPIInstrument: PaymentInstrument {
    
    public let upiId: String
    public let upiName: String
    
    public init(upiId: String, upiName: String) {
        self.upiId = upiId
        self.upiName = upiName
    }
 
    public func toSDK() -> SDKMapping {
        SDKMapping(
            method: UPIPaymentMethod(),
            details: UPIPaymentDetails(
                upiId: upiId,
                upiName: upiName
            )
        )
    }
}
