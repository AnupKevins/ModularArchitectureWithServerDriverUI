//
//  AppAdapter.swift
//  ServerDrivenUI
//
//  Created by Anup Sahu on 01/05/26.
//

/// Adapter (bridge SDK → Core)

import CoreModule
import PaymentSDKWithUIForPaymentSelection

final class PaymentUIServiceAdapter: PaymentUIService {
    
    private let sdkService: PaymentSDKWithUIForPaymentSelection.PaymentSDKUIService
    
    init(sdkService: PaymentSDKWithUIForPaymentSelection.PaymentSDKUIService) {
        self.sdkService = sdkService
    }
    
    func startPayment(amount: Double) async throws -> PaymentResultOfUISdk {
        let response = try await sdkService.startPayment(amount: amount)
        
        return PaymentResultOfUISdk(
            transactionId: response.transactionId,
            status: mapStatus(response.status)
        )
    }
    
    private func mapStatus(_ status: PaymentStatus) -> String {
        switch status {
            case .success: return "success"
            case .pending: return "pending"
            case .failed: return "failed"
        }
    }
}

