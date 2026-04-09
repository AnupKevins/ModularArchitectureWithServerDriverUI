//
//  PaymentRepository.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 31/03/26.
//

public protocol PaymentRepository: Sendable {
    
    func makePayment(request: PaymentRequestModel) async throws -> PaymentResponse
}
