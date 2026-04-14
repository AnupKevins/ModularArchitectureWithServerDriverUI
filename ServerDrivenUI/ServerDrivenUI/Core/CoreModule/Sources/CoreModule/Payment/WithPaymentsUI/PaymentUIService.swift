//
//  PaymentUIService.swift
//  CoreModule
//
//  Created by Anup Sahu on 13/04/26.
//

public protocol PaymentUIService: Sendable {
    func pay(amount: Double) async throws -> PaymentResult
}
