//
//  RetryExecutor.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 01/04/26.
//

import Foundation

protocol RetryExecutor: Sendable {
    func execute<T>(
        _ makeAPICallBlock: @escaping () async throws -> T
    ) async throws -> T
}

final class RetryExecutorImpl: RetryExecutor {
    
    private let policy: RetryPolicy
    
    init(policy: RetryPolicy) {
        self.policy = policy
    }
    
    func execute<T>(
        _ makeAPICallBlock: @escaping () async throws -> T
    ) async throws -> T {
        
        var attempt = 0
        
        while true {
            
            do {
                // if api call gave success then return on first attempt
                // if error goes on catch
                return try await makeAPICallBlock() // 2
            } catch {
                
                attempt += 1
                
                if attempt > policy.maxRetries {
                    throw error
                }
                
                let delay = computeDelay(for: attempt)
                
                let ns = UInt64(delay * 1_000_000_000) // nanoseconds
                // 1 second = 1,000,000,000 nanoseconds (10⁹)
                
                try await Task.sleep(nanoseconds: ns)
                // Why not use seconds directly?
                
                // Because Task.sleep is designed for precision, not convenience.
            }
        }
    }
      
    private func computeDelay(for attempt: Int) -> TimeInterval {
        // delay = 0.5 * 2^1
        let delay = policy.baseDelay * pow(policy.multiplier, Double(attempt - 1))
        
        return min(delay, policy.maxDelay)
    }
}
