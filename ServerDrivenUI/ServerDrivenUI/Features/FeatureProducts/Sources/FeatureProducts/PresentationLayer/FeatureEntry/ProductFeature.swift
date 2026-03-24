//
//  ProductFeature.swift
//  FeatureProducts
//
//  Created by Anup Sahu on 23/03/26.
//
import CoreModule

public enum ProductFeature {
    
    private static func makeCoordinator(
        apiClient: APIClient
    ) -> ProductCoordinator {
        let builder = ProductFeatureBuilderImpl(apiClient: apiClient)
        return ProductCoordinatorImpl(builder: builder)
    }
    
    @MainActor
    public static func registerResolver(apiClient: APIClient) {
        
        var coordinator: ProductCoordinator?
        
        ResolverRegistry.shared.register(routeType: ProductRoute.self) { route in
            
            if coordinator == nil {
                coordinator = makeCoordinator(apiClient: apiClient)
            }
            
            return coordinator?.build(route: route)
        }
    }
}
