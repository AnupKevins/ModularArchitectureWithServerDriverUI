//
//  PaymentType.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 30/03/26.
//

//public enum PaymentType {
//    case upi
//    case neft
//    case rtgs
//}

// Now we are going with Strategy pattern as
// “enum for simplicity, protocol for scalability” ✅

//PaymentMethod (strategy)
//↓
//PaymentHandler (execution)
//↓
//Registry (lookup)

public protocol PaymentMethod {
    var type: String { get }
}


