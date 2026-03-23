//
//  HomeFeature.swift
//  FeatureHome
//
//  Created by Anup Sahu on 23/03/26.
//

import CoreModule

public enum HomeFeature {
    
    public static func makeCoordinator(
        apiClient: APIClient
    ) -> HomeCoordinator {
        
        let builder = HomeFeatureBuilderImpl(apiClient: apiClient)
        return HomeCoordinatorImpl(homeBuilder: builder)
        
    }
}
