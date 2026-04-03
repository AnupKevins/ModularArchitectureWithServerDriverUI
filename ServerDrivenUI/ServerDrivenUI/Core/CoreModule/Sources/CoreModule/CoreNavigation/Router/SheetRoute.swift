//
//  SheetRoute.swift
//  ServerDrivenUI
//
//  Created by Anup Sahu on 03/04/26.
//

import Foundation
// Make Generic Route
public struct SheetRoute<Route>: Identifiable {
    public var id = UUID()
    public var route: Route
    
    public init(route: Route) {
        self.route = route
    }
}
