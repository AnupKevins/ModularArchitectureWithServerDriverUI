//
//  PaymentHandler.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 02/04/26.
//

protocol PaymentHandler: Sendable {
    
    var methodType: String { get }
    
    func handlePayment(request: PaymentRequestModel) async throws -> PaymentResponse
}
