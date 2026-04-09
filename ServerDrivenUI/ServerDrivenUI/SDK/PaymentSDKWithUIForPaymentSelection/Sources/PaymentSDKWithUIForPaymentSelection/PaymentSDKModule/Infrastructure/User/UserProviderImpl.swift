//
//  UserProviderImpl.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 09/04/26.
//

struct UserProviderImpl: UserProvider {
    
    let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
}
