//
//  UserProvider.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 09/04/26.
//

public protocol UserProvider: Sendable {
    var userId: String { get }
}
