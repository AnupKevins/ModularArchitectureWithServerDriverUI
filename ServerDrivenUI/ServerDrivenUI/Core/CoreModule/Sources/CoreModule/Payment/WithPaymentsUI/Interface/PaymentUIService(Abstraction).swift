//
//  PaymentUIService.swift
//  CoreModule
//
//  Created by Anup Sahu on 13/04/26.
//

import Foundation

/// connects feature module with AppModule to start payment flow with UI and get the result back to feature module
/// it acts like a bridge between feature module and AppModule for payment flow with UI
/// If incase sdk changes no need to change in feature module just need to change in AppModule and implement this protocol accordingly
public protocol PaymentUIService: Sendable {
    func startPayment(amount: Double) async throws -> PaymentResultOfUISdk
}
