//
//  HomeFeature.swift
//  FeatureHome
//
//  Created by Anup Sahu on 23/03/26.
//

import CoreModule

public enum HomeFeature {
    
    public static func makeCoordinator(
        apiClient: APIClient,
        router: AppRouter<AppRoute>
    ) -> HomeCoordinator {
        
        let builder = HomeFeatureBuilderImpl(apiClient: apiClient, appRouter: router)
        return HomeCoordinatorImpl(homeBuilder: builder)
        
    }
}
