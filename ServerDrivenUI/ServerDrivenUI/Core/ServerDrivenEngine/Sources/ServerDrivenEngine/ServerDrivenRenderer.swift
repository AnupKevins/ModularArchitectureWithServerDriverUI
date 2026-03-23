//
//  ServerDrivenRenderer.swift
//  ServerDrivenEngine
//
//  Created by Anup Sahu on 03/03/26.
//

import Foundation
import ServerDrivenModelsKit
import SwiftUI

public struct ServerDrivenRenderer: View {

    let components: [ComponentConfigDTO]
    
    public init(components: [ComponentConfigDTO]) {
        self.components = components
    }
    
    public var body: some View {
        ForEach(components) { component in
            // This shows the view BannerView and CarouselView
            ComponentRegistry.shared.resolve(component)
        }
    }
}
