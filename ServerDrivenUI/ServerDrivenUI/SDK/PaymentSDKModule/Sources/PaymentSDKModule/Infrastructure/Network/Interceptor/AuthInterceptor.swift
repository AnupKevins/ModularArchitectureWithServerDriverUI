//
//  AuthInterceptor.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 31/03/26.
//

import Foundation

final class RequestAuthInterceptorImpl: RequestAuthInterceptor {
    
    private let authProvider: AuthProvider
    
    init(authProvider: AuthProvider) {
        self.authProvider = authProvider
    }
    
    func intercept(_ request: inout URLRequest) async throws {
        
        let token = try await authProvider.getToken()
        
        request.addValue("Bearer \(token.token)", forHTTPHeaderField: "Authorization")
        
    }
}
