//
//  IdempotencyStore.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 01/04/26.
//

import Foundation

actor IdempotencyStore {
    private var keys: Set<String> = []
    
    func check(key: String) -> Bool {
        if keys.contains(key) {
            return false
        }
        keys.insert(key)
        return true
    }
}
