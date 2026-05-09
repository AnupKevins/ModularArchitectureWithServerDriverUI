import Foundation

/// Protocol for making network requests
/// Generic over APIRequest so it can decode any response type
protocol NetworkClient: Sendable {
    func request<R: APIRequest>(_ request: R) async throws -> R.Response
}

final class NetworkClientImpl: NetworkClient {
    
    private let session: URLSession
    private let baseURL: URL
    private let decoder: JSONDecoder
    private let interceptors: [RequestAuthInterceptor]
    
    /// Optional retry executor
    /// If provided → request will automatically retry on failure
    private let retryExecutor: RetryExecutor?
    
    init(
        session: URLSession = .shared,
        baseURL: URL,
        decoder: JSONDecoder = JSONDecoder(),
        interceptors: [RequestAuthInterceptor],
        retryPolicy: RetryPolicy? = nil
    ) {
        self.session = session
        self.baseURL = baseURL
        self.decoder = decoder
        self.interceptors = interceptors
        
        /// If retry policy is provided → create retry executor
        /// Otherwise → no retry (single attempt)
        if let retryPolicy = retryPolicy {
            retryExecutor = RetryExecutorImpl(policy: retryPolicy)
        } else {
            retryExecutor = nil
        }
    }
    
    func request<R: APIRequest>(_ request: R) async throws -> R.Response {
        
        /// 🔥 Step 1: Wrap actual API call in a closure
        /// This closure will be executed multiple times by RetryExecutor
        let closureTask = {
            try await self.performRequest(request) // (3)
        }
        
        /// 🔥 Step 2: If retryExecutor exists → delegate execution to it
        /// RetryExecutor will:
        /// - call closure
        /// - retry on failure
        /// - apply delay between retries
        if let retryExecutor = retryExecutor {
            return try await retryExecutor.execute(closureTask) // (1)
        } else {
            /// No retry → execute once
            return try await closureTask()
        }
    }
    
    private func performRequest<R: APIRequest>(_ request: R) async throws -> R.Response {
        
        /// 🔥 Step 3: Build URLRequest from APIRequest
        var urlRequest = try request.makeURLRequest(baseURL: baseURL)
        
        /// 🔥 Step 4: Apply interceptors (e.g. Auth token injection)
        /// Each interceptor can mutate request (headers, tokens, etc.)
        for interceptor in interceptors {
            try await interceptor.intercept(&urlRequest)
        }
        // Apply Interceptors to add token
        // AuthInterceptor → “Are you logged in?”
        // Backend authentication and dont need in UPI
        //        Selector
        //        ↓
        //        Authenticator (UPI)
        //        ↓
        //        App switch → UPI app
        //        ↓
        //        User authenticates (PIN)
        //        ↓
        //        Return to app
        //        ↓
        //        Repository → verify status (AuthInterceptor used here)
        //        ↓
        //        Processor → response
        
        /// 🔥 Step 5: Perform actual network call
        let (data, response) = try await session.data(for: urlRequest)
        
        /// 🔥 Step 6: Validate HTTP response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        /// If status code is not 2xx → throw error
        /// This error will trigger retry (if enabled)
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidStatusCode(httpResponse.statusCode)
        }
        
        /// 🔥 Step 7: Decode response
        do {
            return try decoder.decode(R.Response.self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}
