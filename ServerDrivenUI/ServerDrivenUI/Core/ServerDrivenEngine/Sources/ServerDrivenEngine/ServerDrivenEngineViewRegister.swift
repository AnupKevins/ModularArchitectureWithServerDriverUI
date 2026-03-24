//
//  ServerDrivenEngineViewRegister.swift
//  ServerDrivenEngine
//
//  Created by Anup Sahu on 03/03/26.
//

public struct ServerDrivenEngineViewRegister {
    @MainActor public static func registerDefaults() {
        
        let components: [ServerDrivenComponent.Type] = [
            BannerComponent.self,
            CarouselComponent.self
        ]
        for component in components {
            ComponentRegistry.shared.register(component)
        }
    }
}
