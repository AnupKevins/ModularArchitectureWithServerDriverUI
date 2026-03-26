//
//  ImageLoader+Environement.swift
//  CoreModule
//
//  Created by Anup Sahu on 26/03/26.
//

import SwiftUI

private struct ImageLoaderKey: EnvironmentKey {
    static let defaultValue: ImageLoader? = nil
}

public extension EnvironmentValues {
    var imageLoader: ImageLoader? {
        get {
            self[ImageLoaderKey.self]
        } set {
            self[ImageLoaderKey.self] = newValue
        }
    }
}
