//
//  AuthProvider.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 30/03/26.
//

protocol AuthProvider: Sendable {
    func getToken() async throws -> AuthToken
}

struct AuthToken {
    let token: String
}
