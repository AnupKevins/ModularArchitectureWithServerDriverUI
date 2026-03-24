//
//  AppEnvironment.swift
//  ServerDrivenUI
//
//  Created by Anup Sahu on 03/03/26.
//

import Foundation

enum AppEnvironment {
    case dev
    case stage
    case prod
    
    var baseURL: URL {
        switch self {
            case .dev:
                return URL(string: "http://localhost:3000")!
            case .stage:
                return URL(string: "https://api.stage.example.com")!
            case .prod:
                return URL(string: "https://api.prod.example.com")!
        }
    }
}
