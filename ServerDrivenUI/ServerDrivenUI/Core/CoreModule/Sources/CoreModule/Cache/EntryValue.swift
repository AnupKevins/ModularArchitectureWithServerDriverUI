//
//  EntryValue.swift
//  CoreModule
//
//  Created by Anup Sahu on 26/03/26.
//

import Foundation

final class Entry<Value> {
    let value: Value
    
    init(_ value: Value) {
        self.value = value
    }
}
