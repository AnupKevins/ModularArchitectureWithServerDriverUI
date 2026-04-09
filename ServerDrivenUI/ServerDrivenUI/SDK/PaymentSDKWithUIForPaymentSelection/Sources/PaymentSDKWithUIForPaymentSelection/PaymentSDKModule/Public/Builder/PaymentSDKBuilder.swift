//
//  PaymentSDKBuilder.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 01/04/26.
//

import Foundation

public final class PaymentSDKBuilder {
    
    private let baseURL: URL
    private var customTypes: [String] = []
    private var userProvider: UserProvider?
    
    public init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    // 🔥 Client can add Custom handlers
    public func registerMethod(type: String) -> Self {
        customTypes.append(type)
        return self
    }
    
    public func setUserProvider(_ provider: UserProvider) -> Self {
        self.userProvider = provider
        return self
    }
    
    public func build() -> PaymentSDK {
        
        guard let userProvider else {
            fatalError("UserProvider must be set before PaymentSDK")
        }
        
        let networkClientAuth = NetworkClientImpl(baseURL: baseURL, interceptors: [])
        
        let authProvider = AuthProviderImpl(networkClient: networkClientAuth)
        
        let authInterceptor = RequestAuthInterceptorImpl(authProvider: authProvider)
        
        let networkClient = NetworkClientImpl(
            baseURL: baseURL,
            interceptors: [authInterceptor]
        )
        
        let repository = PaymentRepositoryImpl(networkClient: networkClient)
        
        // Default Handlers
        var handlers: [PaymentHandler] = [
            UPIHandler(paymentRepository: repository),
            NEFTHandler(paymentRepository: repository)
        ]
        
        // 🔥 Add CustomHandler
        handlers += customTypes.map {
            CustomPaymentHandler(repository: repository, methodType: $0)
        }
        
        // 🔥 Incase of strategy pattern (no enum used) Registry setup
        let registry = PaymentHandlerRegistry(handlers: handlers)
        
        // For enum
       // let processor = PaymentProcessor(repository: repository)
        
        let processor = PaymentProcessor(registry: registry)
        
        return PaymentSDKImpl(paymentProcessor: processor)
        
    }
    
}
