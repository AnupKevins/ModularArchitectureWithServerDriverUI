//
//  PaymentDetails.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 06/04/26.
//

public protocol PaymentDetails: Sendable {
    func toDictionary() -> [String: Any]
}
