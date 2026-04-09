//
//  CustomPaymentHandler.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 06/04/26.
//

public final class CustomPaymentHandler: PaymentHandler {
    
    public let methodType: String
    private let repository: PaymentRepository
    
    public init(repository: PaymentRepository, methodType: String) {
        self.repository = repository
        self.methodType = methodType
    }
    
    public func handlePayment(request: PaymentRequestModel) async throws -> PaymentResponse {
        try await repository.makePayment(request: request)
    }
}
