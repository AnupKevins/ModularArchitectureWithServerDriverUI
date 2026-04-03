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
        
        // 🔥 Incase of strategy pattern (no enum used) Registry setup
        let registry = PaymentHandlerRegistry(handlers: [
            UPIHandler(paymentRepository: repository),
            NEFTHandler(paymentRepository: repository)
        ])
        
        // For enum
       // let processor = PaymentProcessor(repository: repository)
        
        let processor = PaymentProcessor(registry: registry)
        
        return PaymentSDKImpl(paymentProcessor: processor)
        
    }
    
}
