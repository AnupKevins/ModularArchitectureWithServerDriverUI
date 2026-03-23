//
//  ServerDrivenEngineViewRegister.swift
//  ServerDrivenEngine
//
//  Created by Anup Sahu on 03/03/26.
//

@MainActor
public struct ServerDrivenEngineViewRegister {
    public static func registerDefaults() {
        ComponentRegistry.shared.register(BannerComponent.self)
        ComponentRegistry.shared.register(CarouselComponent.self)
    }
}
