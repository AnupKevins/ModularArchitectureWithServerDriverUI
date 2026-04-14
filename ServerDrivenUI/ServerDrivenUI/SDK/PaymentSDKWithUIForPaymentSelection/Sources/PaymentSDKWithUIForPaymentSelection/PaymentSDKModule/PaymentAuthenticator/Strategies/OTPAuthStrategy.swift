//
//  OTPAuthStrategy.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 14/04/26.
//

final class OTPAuthStrategy: PaymentAuthStrategy {
    
    private let presenter: PaymentPresenter
    
    init(presenter: PaymentPresenter) {
        self.presenter = presenter
    }
    
    @MainActor
    func authenticate(paymentSelection: PaymentSelection) async throws -> AuthResult {
        <#code#>
    }
}
