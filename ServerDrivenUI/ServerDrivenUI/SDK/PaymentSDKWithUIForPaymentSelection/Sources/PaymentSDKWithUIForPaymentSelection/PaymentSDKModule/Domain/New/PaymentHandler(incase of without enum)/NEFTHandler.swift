//
//  NEFTHandler.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 02/04/26.
//

final class NEFTHandler: PaymentHandler {
    
    let methodType = "NEFT"
    
    let paymentRepository: PaymentRepository
    
    init(paymentRepository: PaymentRepository) {
        self.paymentRepository = paymentRepository
    }
    
    func handlePayment(request: PaymentRequestModel) async throws -> PaymentResponse {
        return try await paymentRepository.makePayment(request: request)
    }
}
