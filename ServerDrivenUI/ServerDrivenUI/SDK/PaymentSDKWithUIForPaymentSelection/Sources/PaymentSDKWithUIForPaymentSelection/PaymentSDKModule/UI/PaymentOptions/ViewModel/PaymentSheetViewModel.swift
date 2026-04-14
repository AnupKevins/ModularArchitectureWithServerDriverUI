//
//  PaymentSheetViewModel.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 09/04/26.
//

import Observation

@MainActor
@Observable
final class PaymentSheetViewModel {
    
    var options: [PaymentOption] = []
    var isLoading: Bool = false
    // Stored Closure property
    var onSelect: ((PaymentOption) -> Void)?
    
    func loadOptions() async {
        isLoading = true
        
        defer { isLoading = false }
        
        // Just like making API call but it right now hardcoded it
        options = [
            PaymentOption(title: "UPI", type: "UPI"),
            PaymentOption(title: "Wallet", type: "Wallet")
        ]
    }
    
    func didSelect(_ option: PaymentOption) {
        onSelect?(option)
    }
}
