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
        apiClient: APIClient,
        paymentService: PaymentService,
        paymentUIService: PaymentUIService
    ) -> HomeCoordinator {
        
        let builder = HomeFeatureBuilderImpl(
            apiClient: apiClient,
            paymentService: paymentService,
            paymentUIService: paymentUIService
        )
        return HomeCoordinatorImpl(homeBuilder: builder)
        
    }
    
    @MainActor
    public static func registerResolver(
        apiClient: APIClient,
        paymentService: PaymentService,
        paymentUIService: PaymentUIService
    ) {
        
        var coordinator: HomeCoordinator?
        
        ResolverRegistry.shared.register(routeType: ServerDrivenHomeRoute.self) { route in
            
            if coordinator == nil {
                coordinator = makeCoordinator(
                    apiClient: apiClient,
                    paymentService: paymentService,
                    paymentUIService: paymentUIService
                )
            }
            
            return coordinator?.build(route: route)
        }
    }
}
