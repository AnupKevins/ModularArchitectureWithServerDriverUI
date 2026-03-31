//
//  RequestInterceptor.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 31/03/26.
//

import Foundation

public protocol RequestInterceptor: Sendable {
    func intercept(_ request: inout URLRequest) async throws
}
