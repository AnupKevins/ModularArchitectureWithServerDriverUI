//
//  UserRequest.swift
//  FeatureHome
//
//  Created by Anup Sahu on 20/03/26.
//

import Foundation
import CoreModule
import ServerDrivenModelsKit

struct HomeRequest: APIRequest {
    typealias Response = ServerPageResponseDTO
    
    var path: String { "Users" }
    
    var httpMethod: HttpMethod { .get }
}
