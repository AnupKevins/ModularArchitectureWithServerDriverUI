//
//  PaymentOption.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 01/05/26.
//

public enum PaymentSDKError: Error {
    case duplicateRequest
    case authenticationFailed
    case paymentFailed
    case invalidInput
    case unsupportedPaymentMethod
}
