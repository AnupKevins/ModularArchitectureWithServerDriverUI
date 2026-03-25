//
//  VoiceOverBuilder.swift
//  FeatureVoiceOver
//
//  Created by Anup Sahu on 25/03/26.
//

import SwiftUI

protocol VoiceOverBuilder {
    func makeVoiceOverView() -> AnyView
}

final class VoiceOverBuilderImpl: VoiceOverBuilder {
    func makeVoiceOverView() -> AnyView {
        print("@@@ makeVoiceOverView")
        return AnyView(AccessibilityVoiceOver())
    }
}
