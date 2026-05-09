//
//  PaymentStatus.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 06/05/26.
//

public enum PaymentStatus {
    case success
    case failed
    case pending
    
    var rawValue: String {
        switch self {
            case .success:
                return "success"
            case .failed:
                return "failed"
            case .pending:
                return "pending"
        }
    }
}
