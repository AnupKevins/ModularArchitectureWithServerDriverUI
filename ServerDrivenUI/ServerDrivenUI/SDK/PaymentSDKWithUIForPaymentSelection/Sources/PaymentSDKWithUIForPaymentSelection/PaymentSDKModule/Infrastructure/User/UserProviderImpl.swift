//
//  UserProviderImpl.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 09/04/26.
//

public struct UserProviderImpl: UserProvider {
    
    public let userId: String
    
    public init(userId: String) {
        self.userId = userId
    }
}
