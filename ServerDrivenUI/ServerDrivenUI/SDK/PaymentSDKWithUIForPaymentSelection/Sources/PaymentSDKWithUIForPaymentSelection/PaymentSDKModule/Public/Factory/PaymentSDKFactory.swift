//
//  PaymentSDKFactory.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 21/04/26.
//

@MainActor
public enum PaymentSDKFactory {
    
    public static func makeUIService(
        config: PaymentUIConfig
    ) -> PaymentSDKUIService {
        
        // ---------------------------
        // 🔥 1. AUTH FLOW (IMPORTANT)
        // ---------------------------
        
        let networkClientAuth = NetworkClientImpl(
            baseURL: config.baseURL, interceptors: []
        )
        
        let authProvider = AuthProviderImpl(
            networkClient: networkClientAuth
        )
        
        let authInterceptor = RequestAuthInterceptorImpl(
            authProvider: authProvider
        )
        
        // ---------------------------
        // 🔥 2. MAIN NETWORK CLIENT
        // ---------------------------
        
        let networkClient = NetworkClientImpl(
            baseURL: config.baseURL,
            interceptors: [authInterceptor]
        )
        
        // ---------------------------
        // 🔥 3. REPOSITORY
        // ---------------------------
        
        let repository = PaymentRepositoryImpl(
            networkClient: networkClient
        )
        
        // ---------------------------
        // 🔥 4. HANDLERS
        // ---------------------------
        
        let handlers: [PaymentHandler] = [
            UPIHandler(paymentRepository: repository),
            NEFTHandler(paymentRepository: repository),
            WalletHandler(paymentRepository: repository),
            CardHandler(paymentRepository: repository)
        ]
        
        let registry = PaymentHandlerRegistry(handlers: handlers)
        
        let processor = PaymentProcessor(registry: registry)
        
        let sdk = PaymentSDKImpl(
            paymentProcessor: processor,
            userProvider: config.userProvider
        )
        
        // ---------------------------
        // 3. PRESENTER (🔥 HERE)
        // ---------------------------
        
        let presenter = PaymentPresenterImpl()

        // ---------------------------
        // 4. PLUGINS
        // ---------------------------
        
        let allPlugins: [PaymentMethodPlugin] = [
            UPIPlugin(),
            NEFTPlugin(),
            CardPlugin(),
            WalletPlugin(presenter: presenter, repository: repository)
        ]
        
        // ---------------------------
        // 🔥 6. UI SERVICE
        // ---------------------------
        
        return PaymentSDKUIServiceImpl(
            sdk: sdk,
            paymentMethodsProvider: config.methodsProvider,
            plugins: allPlugins,
            presenter: presenter
        )
    }
}

