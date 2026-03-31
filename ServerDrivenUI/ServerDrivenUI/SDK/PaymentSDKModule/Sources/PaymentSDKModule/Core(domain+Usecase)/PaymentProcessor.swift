//
//  PaymentProcessor.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 31/03/26.
//

final class PaymentProcessor {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func process(request: PaymentRequest) async throws -> PaymentResponse {
        
        switch request.paymentType {
            case .upi:
                re
        }
    }
}
