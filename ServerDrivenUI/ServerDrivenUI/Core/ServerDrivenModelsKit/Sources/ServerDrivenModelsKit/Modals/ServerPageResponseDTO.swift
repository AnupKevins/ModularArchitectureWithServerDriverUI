//
//  Modal.swift
//  CoreModule
//
//  Created by Anup Sahu on 02/03/26.
//

import Foundation

public struct ServerPageResponseDTO: Decodable {
    public let components: [ComponentConfigDTO]
}

public struct ComponentConfigDTO: Decodable, Identifiable, Sendable {
    public let id: Int
    public let type: String
    public let payload: [String: String]
}
