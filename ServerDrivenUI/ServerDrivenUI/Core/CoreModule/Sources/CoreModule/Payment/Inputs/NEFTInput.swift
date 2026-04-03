//
//  NEFTInput.swift
//  CoreModule
//
//  Created by Anup Sahu on 02/04/26.
//
import PaymentSDKModule

public struct NEFTInstrument: PaymentInstrument {
    
    let accountNumber: String
    let ifscCode: String
    let bankName: String
    
    public func toSDK() -> SDKMapping {
        SDKMapping(
            method: NEFTPaymentMethod(),
            details: BankPaymentDetails(
                accountNumber: accountNumber,
                bankName: bankName,
                ifscCode: ifscCode
            )
        )
    }
}
