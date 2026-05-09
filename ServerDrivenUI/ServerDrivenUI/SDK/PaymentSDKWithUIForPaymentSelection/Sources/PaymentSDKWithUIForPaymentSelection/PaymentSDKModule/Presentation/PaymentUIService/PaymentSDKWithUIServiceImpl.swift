//
//  PaymentSDKUIServiceImpl.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 27/04/26.
//

//✔ calls PaymentMethodsProvider (API trigger)
//✔ selects plugin
//✔ triggers UI flow (OTP, etc.)
//✔ coordinates SDK + plugins

// “PaymentSDKUIServiceImpl belongs to the presentation or application layer because it orchestrates the payment flow and interacts with UI components, while the domain layer remains pure.”

import Foundation
import SwiftUI

final class PaymentSDKUIServiceImpl: PaymentSDKUIService {
    
    private let sdk: PaymentSDKImpl
    private let paymentMethodsProvider: PaymentMethodsProvider
    private let plugins: [PaymentMethodPlugin]
    private let presenter: PaymentPresenter
    
    init(
        sdk: PaymentSDKImpl,
        paymentMethodsProvider: PaymentMethodsProvider,
        plugins: [PaymentMethodPlugin],
        presenter: PaymentPresenter
    ) {
        self.sdk = sdk
        self.paymentMethodsProvider = paymentMethodsProvider
        self.plugins = plugins
        self.presenter = presenter
    }
    
    func startPayment(amount: Double) async throws -> PaymentResponse {
        // Step 1: Fetch available payment methods
        let options = try await paymentMethodsProvider.fetchPaymentOptions()
        
       /// Show List of payment UI
       let selectedOption = try await selectPaymentOption(options)
        
        
        print("@@@ selectedOption: \(selectedOption)")
        
        // Step 2: Select a plugin based on available options (for simplicity, we take the first one)
        guard let plugin = plugins.first(where: { $0.canHandle(selectedOption) }) else {
            throw PaymentSDKError.unsupportedPaymentMethod
            
        }
        
        print("@@@ Before plugin handle")
        
        let selection = try await plugin.handle(option: selectedOption)
        
        print("@@@ After plugin handle") // ← will print after OTP submit
        
        return try await sdk.processPayment(amount: amount, selection: selection)
        
    }
    
    @MainActor
    private func selectPaymentOption(_ options: [PaymentOption]) async throws -> PaymentOption {
        
        /// 🔥 guard to ensure resume only once
        var isResumed = false
        
        return try await withCheckedThrowingContinuation { continuation in
            let view = PaymentOptionView(options: options) { selected in
                /// Closure is NOT stored by self
                /// Closure → owned by SwiftUI view
                /// View → presented temporarily
                
                guard !isResumed else { return }
                isResumed = true
                
                /// 🔥 Wait for dismissal to properly be dellocated
                self.presenter.dismissPaymentSheet(completion: {
                    continuation.resume(returning: selected)
                })
                
            } onCancel: {
                guard !isResumed else { return }
                isResumed = true
                
                /// 🔥 Wait for dismissal to properly be dellocated
                self.presenter.dismissPaymentSheet(completion: {
                    continuation.resume(throwing: CancellationError())
                })
            }
            
            let controller = UIHostingController(rootView: view)
            presenter.presentPaymentSheet(controller)
        }
        
    }
    
}
