//
//  JSONValue.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 10/04/26.
//

import Foundation

public enum JSONValue: Sendable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case object([String: JSONValue])
    case array([JSONValue])
    case null
}

extension JSONValue {
    
    func toAny() -> Any {
        switch self {
            case .string(let value):
                return value
            case .int(let value):
                return value
            case .double(let value):
                return value
            case .bool(let value):
                return value
            case .object(let dict):
                return dict.mapValues { $0.toAny() }
            case .array(let array):
                return array.map { $0.toAny() }
            case .null:
                return NSNull()
        }
    }
}
