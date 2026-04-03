// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
//In App
//UI → ViewModel → UseCase → Repository → API

// In SDK
// Client → SDK Public API → Core → Data Layer

public protocol PaymentSDK: Sendable {
    func pay(request: PaymentRequestModel) async throws -> PaymentResponse
}
