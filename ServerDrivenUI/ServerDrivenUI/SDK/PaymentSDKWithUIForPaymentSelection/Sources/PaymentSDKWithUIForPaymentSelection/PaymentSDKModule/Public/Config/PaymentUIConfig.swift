//
//  PaymentUIConfig.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 21/04/26.
//

import Foundation

public struct PaymentUIConfig {
    public let baseURL: URL
    public let userProvider: UserProvider
    public let methodsProvider: PaymentMethodsProvider
    
    public init(
        baseURL: URL,
        userProvider: UserProvider,
        methodsProvider: PaymentMethodsProvider
    ) {
        self.baseURL = baseURL
        self.userProvider = userProvider
        self.methodsProvider = methodsProvider
    }
}
