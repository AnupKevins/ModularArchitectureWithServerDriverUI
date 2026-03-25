//
//  VoiceOverCoordinator.swift
//  FeatureVoiceOver
//
//  Created by Anup Sahu on 25/03/26.
//

import SwiftUI

protocol VoiceOverCoordinator {
    func build(route: VoiceOverRoute) -> AnyView
}

struct VoiceOverCoordinatorImpl: VoiceOverCoordinator {
    
    private let builder: VoiceOverBuilder
    
    init(builder: VoiceOverBuilder) {
        self.builder = builder
    }
    
    func build(route: VoiceOverRoute) -> AnyView {
        switch route {
            case .voiceOver:
                builder.makeVoiceOverView()
        }
    }
}
