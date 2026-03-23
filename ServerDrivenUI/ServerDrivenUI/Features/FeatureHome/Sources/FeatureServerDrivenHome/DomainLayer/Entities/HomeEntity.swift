//
//  HomePage.swift
//  FeatureHome
//
//  Created by Anup Sahu on 03/03/26.
//

import Foundation

public struct HomeEntity {
    let components: [HomeComponentEntity]
}

struct HomeComponentEntity {
    let id: Int
    let type: String
    let payload: [String: String]
}
