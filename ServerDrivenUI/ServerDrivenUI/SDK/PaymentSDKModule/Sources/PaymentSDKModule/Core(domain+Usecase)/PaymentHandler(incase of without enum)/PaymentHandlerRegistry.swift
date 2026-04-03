//
//  PaymentHandlerRegistry.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 02/04/26.
//
import Foundation
struct PaymentHandlerRegistry: Sendable {
    
    private var dictHandlers: [String: any PaymentHandler] = [:]
    
    init(handlers: [any PaymentHandler]) {
        
        var map: [String: any PaymentHandler] = [:]
        
        for handler in handlers {
            if map[handler.methodType] != nil { // methodType already exists
                print("Duplicate handler for \(handler.methodType)")
            }
            // override the existing one
            map[handler.methodType] = handler
        }
        
        self.dictHandlers = map
    }
    
    func getPaymentHandler(for method: PaymentMethod) -> PaymentHandler? {
        return dictHandlers[method.type]
    }
}
