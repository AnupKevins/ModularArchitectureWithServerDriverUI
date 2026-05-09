//
//  AppPaymentMethodsProvider.swift
//  ServerDrivenUI
//
//  Created by Anup Sahu on 01/05/26.
//

import Foundation
import PaymentSDKWithUIForPaymentSelection
import CoreModule

final class AppPaymentMethodsProvider: PaymentMethodsProvider {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchPaymentOptions() async throws -> [PaymentOption] {
        
        // 🔥 Call YOUR backend
        // Example mock
        return [
            PaymentOption(title: "Wallet", type: "WALLET"),
            PaymentOption(title: "UPI", type: "UPI"),
            PaymentOption(title: "Card", type: "CARD"),
            PaymentOption(title: "NEFT", type: "NEFT")
        ]
    }
}
