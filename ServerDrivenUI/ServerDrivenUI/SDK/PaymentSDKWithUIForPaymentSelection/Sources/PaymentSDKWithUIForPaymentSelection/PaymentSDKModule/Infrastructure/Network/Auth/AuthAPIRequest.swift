//
//  AuthAPIRequest.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 31/03/26.
//

import Foundation

struct AuthTokenResponseDTO: Decodable {
    let token: String
}

struct AuthTokenRequest: APIRequest {
    typealias Response = AuthTokenResponseDTO
    
    var path: String { "auth/token" }
    
    var method: String { "POST" }
    
    var headers: [String : String] { [:] }
    
    var body: Data? { nil }
    
}
