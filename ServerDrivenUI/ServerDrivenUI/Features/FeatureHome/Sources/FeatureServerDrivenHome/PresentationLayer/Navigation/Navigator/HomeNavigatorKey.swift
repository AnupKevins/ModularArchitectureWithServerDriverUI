//
//  EnvironmentKey.swift
//  FeatureHome
//
//  Created by Anup Sahu on 24/03/26.
//

// ✅ Protocol cant be used in @enviroment so create key

import SwiftUI

private struct HomeNavigatorKey: EnvironmentKey {
    static let defaultValue: HomeNavigator? = nil
}

public extension EnvironmentValues {
    
    var homeNavigator: HomeNavigator? {
        get { self[HomeNavigatorKey.self] }
        set { self[HomeNavigatorKey.self] = newValue }
    }
}
