//
//  PaymentDetails.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 30/03/26.
//

public protocol PaymentDetails {
    func toDictionary() -> [String: Any]
}

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
