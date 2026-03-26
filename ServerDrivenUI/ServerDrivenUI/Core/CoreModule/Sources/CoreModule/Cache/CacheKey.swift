//
//  CacheKey'.swift
//  CoreModule
//
//  Created by Anup Sahu on 26/03/26.
//

import Foundation

final class CacheKey<Key: Hashable>: NSObject {
    let key: Key
    
    init(_ key: Key) {
        self.key = key
    }
    
    override var hash: Int {
        key.hashValue
    }
    
    override func isEqual(_ object: Any?) -> Bool {
       (object as? CacheKey)?.key == key
    }
}
