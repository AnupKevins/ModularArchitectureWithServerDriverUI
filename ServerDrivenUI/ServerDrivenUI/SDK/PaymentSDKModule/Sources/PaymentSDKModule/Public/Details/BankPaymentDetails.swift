//
//  PaymentDetails.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 30/03/26.
//

public struct BankPaymentDetails: PaymentDetails {
    public let accountNumber: String
    public let bankName: String
    public let ifscCode: String
    
    public init(accountNumber: String, bankName: String, ifscCode: String) {
        self.accountNumber = accountNumber
        self.bankName = bankName
        self.ifscCode = ifscCode
    }
    
    public func toDictionary() -> [String: Any] {
        [
            "accountNumber": accountNumber,
            "bankName": bankName,
            "ifscCode": ifscCode
        ]
    }
}
