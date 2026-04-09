//
//  CustomPaymentInstrument.swift
//  CoreModule
//
//  Created by Anup Sahu on 07/04/26.
//
import PaymentSDKModule

public struct GenericPaymentInstrument: PaymentInstrument {
    
    private let methodType: String
    private let metaData: [String: Any]
    
    public init(methodType: String, metaData: [String : Any]) {
        self.methodType = methodType
        self.metaData = metaData
    }
    
    public func toSDK() -> SDKMapping {
        return SDKMapping(
            method: CustomPaymentMethod(type: methodType),
            details: CustomPaymentDetail(payload: metaData)
        )
    }
}
