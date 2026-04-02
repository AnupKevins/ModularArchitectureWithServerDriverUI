//
//  PaymentSDKBuilder.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 01/04/26.
//

import Foundation

public final class PaymentSDKBuilder {
    
    private let baseURL: URL
    
    public init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    public func build() -> PaymentSDK {
        let networkClientAuth = NetworkClientImpl(baseURL: baseURL, interceptors: [])
        
        let authProvider = AuthProviderImpl(networkClient: networkClientAuth)
        
        let authInterceptor = RequestAuthInterceptorImpl(authProvider: authProvider)
        
        let networkClient = NetworkClientImpl(
            baseURL: baseURL,
            interceptors: [authInterceptor]
        )
        
        let repository = PaymentRepositoryImpl(networkClient: networkClient)
        
        let processor = PaymentProcessor(repository: repository)
        
        return PaymentSDKImpl(paymentProcessor: processor)
        
    }
    
}
