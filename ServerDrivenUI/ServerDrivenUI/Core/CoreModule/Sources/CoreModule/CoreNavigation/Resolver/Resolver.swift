//
//  Resolver.swift
//  CoreModule
//
//  Created by Anup Sahu on 23/03/26.
//

import SwiftUI

@MainActor
public protocol Resolver {
    func resolve(route: any Hashable) -> AnyView?
}
