//
//  DefaultAuthProvider.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 30/03/26.
//
// AuthProvider is actor because multiple api call
//Task A → enters actor → fetch token
//Task B → waits
//Task A → updates cache
//Task B → gets cached token

import Foundation

public actor AuthProviderImpl: AuthProvider {
    
    private let networkClient: NetworkClient
    private var cachedToken: AuthToken?
    private var expiry: Date?
    private let authTokenRequest: AuthTokenRequest
    
//    Auth token (JWT / OAuth):
//    
//    Identifies user/session
//    Used for authorization
//        Valid for multiple requests
    
    init(networkClient: NetworkClient, authTokenRequest: AuthTokenRequest = AuthTokenRequest()) {
        self.networkClient = networkClient
        self.authTokenRequest = authTokenRequest
    }
    
    func getToken() async throws -> AuthToken {
        // 1. Return cached token if exists
        
        if let token = cachedToken,
           let expiry = expiry,
           expiry > Date() { // Date() return Current timestamp from system clock 2026-03-31 14:23:45 +0000
            // expiry time greater means expiry time is happening in future
            return token
        }
        
        // 2. Fetch New Token
        
        let response = try await networkClient.request(authTokenRequest)
        
        let token = AuthToken(token: response.token)
        
        // 3. Cache token
        cachedToken = token
        expiry = Date().addingTimeInterval(300) // 5 min
        
        return token
    
    }
}
