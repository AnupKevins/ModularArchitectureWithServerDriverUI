//
//  ComponentRegistry.swift
//  ServerDrivenEngine
//
//  Created by Anup Sahu on 03/03/26.
//

import Foundation
import ServerDrivenModelsKit
import SwiftUI

@MainActor
public final class ComponentRegistry {
    public static let shared = ComponentRegistry()
    
    private var registry: [String: ServerDrivenComponent.Type] = [:]
    
    private init() {}
    
    public func register(_ component: ServerDrivenComponent.Type) {
        registry[component.type] = component
    }
    
    @ViewBuilder public func resolve(_ config: ComponentConfigDTO) -> some View {
        if let component = registry[config.type] {
            component.init(config: config).render()
        } else {
            FallbackView()
        }
    }
    
}

