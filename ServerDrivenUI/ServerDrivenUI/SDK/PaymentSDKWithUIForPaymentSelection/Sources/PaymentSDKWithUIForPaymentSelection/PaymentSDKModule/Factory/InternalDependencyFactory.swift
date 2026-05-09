//
//  InternalDependencyFactory.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 09/05/26.
//

/// Since your factory creates:
/// ✔ presenter
/// ✔ plugins with UI
/// ✔ UI service

@MainActor
final class InternalDependencyFactory {
    
    private let config: PaymentUIConfig
    
    init(config: PaymentUIConfig) {
        self.config = config
    }
    
    /// Public entry point used by PaymentSDKFactory
    func makePaymentSDKUIService() -> PaymentSDKUIService {
        
        let repository = makeRepository()
        let presenter = makePresenter()
        
        let plugins = makePlugins(
            repository: repository,
            presenter: presenter
        )
        
        let processor = makeProcessor(
            repository: repository
        )
        
        let sdk = PaymentSDKImpl(
            paymentProcessor: processor,
            userProvider: config.userProvider
        )
        
        return PaymentSDKUIServiceImpl(
            sdk: sdk,
            paymentMethodsProvider: config.methodsProvider,
            plugins: plugins,
            presenter: presenter
        )
    }
}

// MARK: - Repository
private extension InternalDependencyFactory {
    func makeRepository() -> PaymentRepository {
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
            interceptors: [authInterceptor],
            retryPolicy: RetryPolicy(
                maxRetries: 3,
                baseDelay: 0.5,
                multiplier: 2,
                maxDelay: 3
            )
        )
        
        // ---------------------------
        // 🔥 3. REPOSITORY
        // ---------------------------
        
        let repository = PaymentRepositoryImpl(
            networkClient: networkClient
        )
        
        return repository
    }
}

// MARK: - Presenter
private extension InternalDependencyFactory {
    func makePresenter() -> PaymentPresenter {
        return PaymentPresenterImpl()
    }
}

// MARK: - Plugins

private extension InternalDependencyFactory {
    func makePlugins(
        repository: PaymentRepository,
        presenter: PaymentPresenter
    ) -> [PaymentMethodPlugin] {
        
        [
            /// 🔥 UPI Flow
            UPIPlugin(),
            /// 🔥 Wallet Flow
            /// Handles:
            /// - OTP UI
            /// - OTP validation
            /// - auth token generation
            WalletPlugin(
                presenter: presenter,
                repository: repository
            ),
            /// 🔥 Bank Transfer Flow
            NEFTPlugin(),
            /// 🔥 Card Flow
            /// Usually:
            /// - 3DS
            /// - WebView
            /// - OTP
            CardPlugin()
        ]
    }
}

// MARK: - Processor

private extension InternalDependencyFactory {

    func makeProcessor(
        repository: PaymentRepository
    ) -> PaymentProcessor {

        /// 🔥 Each handler is responsible for
        /// backend payment execution
        let handlers: [PaymentHandler] = [

            UPIHandler(
                paymentRepository: repository
            ),
            WalletHandler(
                paymentRepository: repository
            ),
            CardHandler(
                paymentRepository: repository
            ),
            NEFTHandler(
                paymentRepository: repository
            )
        ]

        /// 🔥 Registry helps processor find
        /// correct handler dynamically
        let registry = PaymentHandlerRegistry(
            handlers: handlers
        )

        return PaymentProcessor(
            registry: registry
        )
    }
}

