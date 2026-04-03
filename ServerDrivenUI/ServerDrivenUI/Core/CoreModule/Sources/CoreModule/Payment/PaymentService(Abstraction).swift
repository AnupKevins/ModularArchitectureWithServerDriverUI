//
//  PaymentService.swift
//  CoreModule
//
//  Created by Anup Sahu on 02/04/26.
//

// ✅“SharedModule is for utilities, CoreModule is for business abstractions.”
import PaymentSDKModule

public protocol PaymentService: Sendable {
    func pay(input: PaymentInput) async throws -> PaymentResponse
}
