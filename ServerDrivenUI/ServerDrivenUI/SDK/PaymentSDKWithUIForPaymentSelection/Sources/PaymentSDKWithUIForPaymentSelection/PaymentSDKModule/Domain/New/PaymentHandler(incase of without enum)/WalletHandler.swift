//
//  WalletHandler.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 21/04/26.
//

final class WalletHandler: PaymentHandler {
    
    let methodType = "WALLET"
    
    let paymentRepository: PaymentRepository
    
    init(paymentRepository: PaymentRepository) {
        self.paymentRepository = paymentRepository
    }
    
    func handlePayment(request: PaymentRequestModel) async throws -> PaymentResponse {
        return try await paymentRepository.makePayment(request: request)
    }
}
