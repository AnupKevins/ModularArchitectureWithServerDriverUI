//
//  BannerView.swift
//  ServerDrivenEngine
//
//  Created by Anup Sahu on 03/03/26.
//

import Foundation
import ServerDrivenModelsKit
import SwiftUI

struct BannerComponent: ServerDrivenComponent {
    static var type: String { "banner" }
    
    let config: ComponentConfigDTO
    
    init(config: ComponentConfigDTO) {
        self.config = config
    }
    
    func render() -> AnyView {
        AnyView(
            Text(config.payload["title"] ?? "")
                .padding(10)
                .background(Color.red)
        )
    }
}
