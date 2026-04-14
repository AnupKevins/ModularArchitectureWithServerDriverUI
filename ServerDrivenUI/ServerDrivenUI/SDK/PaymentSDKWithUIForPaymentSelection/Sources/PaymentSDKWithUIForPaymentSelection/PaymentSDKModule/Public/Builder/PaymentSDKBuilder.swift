//
//  PaymentSDKBuilder.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 01/04/26.
//

import Foundation

@MainActor
public final class PaymentSDKBuilderWithPaymentUI {
    
    private let baseURL: URL
    private var customTypes: [String] = []
    private var userProvider: UserProvider?
    private var presenter: PaymentPresenter?
    
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
    
    // ✅ New: Presenter Injection
    public func setPresenter(_ presenter: PaymentPresenter) -> Self {
        self.presenter = presenter
        return self
    }
    
    public func build() -> PaymentSDKWithUI {
        
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
        
        // 🔥 Selector with ViewModel factory
        guard let presenter else {
            fatalError("Presenter must be set before PaymentSDK")
        }
        let selector = PaymentMethodSelectorImpl(
            presenter: presenter,
            viewModelFactory: {
                PaymentSheetViewModel()
            }
        )
        
        return PaymentSDKImpl(
            paymentProcessor: processor,
            selector: selector,
            userProvider: userProvider
        )
        
    }
    
}
