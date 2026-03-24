//
//  HomeFeature.swift
//  FeatureHome
//
//  Created by Anup Sahu on 23/03/26.
//

import CoreModule

public enum HomeFeature {
    
    @MainActor
    private static func makeCoordinator(
        apiClient: APIClient
    ) -> HomeCoordinator {
        
        let builder = HomeFeatureBuilderImpl(apiClient: apiClient)
        return HomeCoordinatorImpl(homeBuilder: builder)
        
    }
    
    @MainActor
    public static func registerResolver(apiClient: APIClient) {
        
        var coordinator: HomeCoordinator?
        
        ResolverRegistry.shared.register { route in
            
            guard let route = route as? ServerDrivenHomeRoute else {
                return nil
            }
            
            if coordinator == nil {
                coordinator = makeCoordinator(apiClient: apiClient)
            }
            
            return coordinator?.build(route: route)
        }
    }
}
