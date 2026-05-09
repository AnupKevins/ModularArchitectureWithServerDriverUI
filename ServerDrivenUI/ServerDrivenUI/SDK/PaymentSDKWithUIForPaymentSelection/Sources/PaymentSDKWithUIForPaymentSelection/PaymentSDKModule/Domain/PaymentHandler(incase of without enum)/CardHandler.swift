//
//  CardHandler.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 21/04/26.
//

final class CardHandler: PaymentHandler {
    
    let methodType = "CARD"
    
    let paymentRepository: PaymentRepository
    
    init(paymentRepository: PaymentRepository) {
        self.paymentRepository = paymentRepository
    }
    
    func handlePayment(request: PaymentRequestModel) async throws -> PaymentResponse {
        return try await paymentRepository.makePayment(request: request)
    }
}
