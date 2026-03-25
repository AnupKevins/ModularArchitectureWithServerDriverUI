//
//  VoiceOverFeature.swift
//  FeatureVoiceOver
//
//  Created by Anup Sahu on 25/03/26.
//

import CoreModule

public enum VoiceOverFeature {
    
    private static func makeCoordinator() -> VoiceOverCoordinator {
        let builder = VoiceOverBuilderImpl()
        return VoiceOverCoordinatorImpl(builder: builder)
    }
    
    @MainActor
    public static func registerResolver() {
        
        var coordinator: VoiceOverCoordinator?
        
        ResolverRegistry.shared.register(routeType: VoiceOverRoute.self) { route in
            if coordinator == nil {
               coordinator = makeCoordinator()
            }
            
            return coordinator?.build(route: route)
        }
        
    }
}
