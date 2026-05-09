//
//  WalletPlugin.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 21/04/26.
//

import SwiftUI

final class WalletPlugin: PaymentMethodPlugin {
    
    let type = "WALLET"
    let displayName = "Wallet"
    
    private let presenter: PaymentPresenter
    private let repository: PaymentRepository // 🔥 needed for otp Api call
    
    init(presenter: PaymentPresenter, repository: PaymentRepository) {
        self.presenter = presenter
        self.repository = repository
    }
    
    func canHandle(_ option: PaymentOption) -> Bool {
        option.type == type
    }
    
    func handle(option: PaymentOption) async throws -> PaymentSelection {
        
        // 🔥 Step 1: Get Otp from User
        let otp = try await collectOtp()
        
        let repo = self.repository
        
        // 🔥 Step 2: Validate OTP and get auth token
        let authToken = try await validateOTPandGetToken(otp, repository: repo)
        
        return PaymentSelection(
            methodType: "WALLET",
            details: .wallet(walletId: "paytm", authToken: authToken)
        )
    }
}

extension WalletPlugin {
    @MainActor
    private func collectOtp() async throws -> String {
        
        /// 🔥 guard to ensure resume only once
        var isResumed = false
        
        return try await withCheckedThrowingContinuation { continuation in
            
            let view = OTPView(
                onSubmit: { otp in
                    
                    guard !isResumed else { return }
                    isResumed = true
                    
                    self.presenter.dismissPaymentSheet {
                        continuation.resume(returning: otp)
                    }
                    
                },
                onCancel: {
                    guard !isResumed else { return }
                    isResumed = true
                    
                    self.presenter.dismissPaymentSheet {
                        continuation.resume(throwing: CancellationError())
                    }
                }
            )
            
            let controller = UIHostingController(rootView: view)
            presenter.presentPaymentSheet(controller)
        }
    }
}

extension WalletPlugin {
    
    private func validateOTPandGetToken(_ otp: String, repository: PaymentRepository) async throws -> String {
        
        // 🔥 call repository -> backend
        let responseAuthToken = try await repository.validateWalletOTP(otp: otp)
        
        // Example validation
        return responseAuthToken
    }
}
