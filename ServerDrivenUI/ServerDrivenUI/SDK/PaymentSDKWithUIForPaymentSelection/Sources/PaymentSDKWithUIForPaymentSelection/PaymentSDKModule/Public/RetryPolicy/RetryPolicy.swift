//
//  RetryPolicy.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 01/04/26.
//

import Foundation
// Exponential backoff Retry
// Sendable = safe to transfer across thread
//At compile-time:
//
//discourages unsafe shared mutable state
//ensures stored properties are safe types
public struct RetryPolicy: Sendable {
    
    public let maxRetries: Int
    public let baseDelay: TimeInterval // initial Delay
    public let multiplier: Double // growth factor
    public let maxDelay: TimeInterval
    
    public init(
        maxRetries: Int = 3,
        baseDelay: TimeInterval = 0.5,
        multiplier: Double = 2.0,
        maxDelay: TimeInterval = 5
    ) {
        self.maxRetries = maxRetries
        self.baseDelay = baseDelay
        self.multiplier = multiplier
        self.maxDelay = maxDelay
    }
}
