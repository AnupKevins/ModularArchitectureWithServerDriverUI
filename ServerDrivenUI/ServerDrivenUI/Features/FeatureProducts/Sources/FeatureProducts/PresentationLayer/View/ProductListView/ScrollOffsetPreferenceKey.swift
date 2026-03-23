//
//  PreferenceKey.swift
//  FeatureProducts
//
//  Created by Anup Sahu on 04/03/26.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    
    static let defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
