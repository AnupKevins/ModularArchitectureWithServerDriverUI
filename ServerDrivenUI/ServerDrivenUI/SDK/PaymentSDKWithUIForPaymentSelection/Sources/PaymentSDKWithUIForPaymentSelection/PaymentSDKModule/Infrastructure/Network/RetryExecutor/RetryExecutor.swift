import Foundation

/// Handles retry logic for any async task
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
        
        /// Tracks how many attempts have been made
        var attempt = 0
        
        while true {
            
            do {
                /// 🔥 Step 2: Execute API call
                /// If success → immediately return result
                return try await makeAPICallBlock()
                
            } catch {
                
                /// 🔥 Step 3: Failure occurred → increment attempt count
                attempt += 1
                
                /// If exceeded max retries → propagate error
                if attempt > policy.maxRetries {
                    throw error
                }
                
                /// 🔥 Step 4: Compute exponential backoff delay
                let delay = computeDelay(for: attempt)
                
                /// Convert seconds → nanoseconds
                /// Task.sleep expects nanoseconds for precision
                let ns = UInt64(delay * 1_000_000_000)
                
                /// 🔥 Step 5: Wait before retrying
                try await Task.sleep(nanoseconds: ns)
                
                /// Loop continues → retry again
            }
        }
    }
    
    /// 🔥 Exponential backoff formula
    /// delay = baseDelay * multiplier^(attempt-1)
    private func computeDelay(for attempt: Int) -> TimeInterval {
        
        let delay = policy.baseDelay * pow(policy.multiplier, Double(attempt - 1))
        
        /// Cap delay to avoid infinite growth
        return min(delay, policy.maxDelay)
    }
}
