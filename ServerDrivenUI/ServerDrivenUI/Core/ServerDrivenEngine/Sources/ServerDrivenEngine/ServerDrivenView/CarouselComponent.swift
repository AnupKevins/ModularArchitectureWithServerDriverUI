//
//  CarouselComponent.swift
//  ServerDrivenEngine
//
//  Created by Anup Sahu on 03/03/26.
//

import Foundation
import SwiftUI
import ServerDrivenModelsKit

struct CarouselComponent: ServerDrivenComponent {
    static var type: String { "productCarousel" }
    
    let config: ComponentConfigDTO
    
    init(config: ComponentConfigDTO) {
        self.config = config
    }
    
    func render() -> AnyView {
        AnyView(Text(config.payload["categoryId"] ?? ""))
    }
}
