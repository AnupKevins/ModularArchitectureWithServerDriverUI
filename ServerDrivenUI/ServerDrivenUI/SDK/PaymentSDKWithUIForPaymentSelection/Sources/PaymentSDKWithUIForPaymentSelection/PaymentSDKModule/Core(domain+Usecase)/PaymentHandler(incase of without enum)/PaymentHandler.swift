//
//  PaymentHandler.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 02/04/26.
//

// make public for custom payment
public protocol PaymentHandler: Sendable {
    
    var methodType: String { get }
    
    func handlePayment(request: PaymentRequestModel) async throws -> PaymentResponse
}
