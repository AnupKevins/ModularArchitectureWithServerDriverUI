// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import ServerDrivenModelsKit
import SwiftUI

public protocol ServerDrivenComponent {
    static var type: String { get } // we need the type before creating the instance
    init(config: ComponentConfigDTO)
    func render() -> AnyView
}
