//
//  ViewModifier.swift
//  FeatureProducts
//
//  Created by Anup Sahu on 04/03/26.
//

import SwiftUI

struct TitleViewModifier: ViewModifier {
    
    var fontSize: CGFloat
    func body(content: Content) -> some View {
        content
        .font(.system(size: fontSize * 0.04))
        .multilineTextAlignment(.leading)
        .background(Color(.systemGray6))
    }
}
