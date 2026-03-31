//
//  PaymentRepository.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 31/03/26.
//

protocol PaymentRepository {
    
    func makePayment(request: PaymentRequest) async throws -> PaymentResponse
}
