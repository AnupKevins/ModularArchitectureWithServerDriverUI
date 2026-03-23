//
//  ProductFeature.swift
//  FeatureProducts
//
//  Created by Anup Sahu on 23/03/26.
//
import CoreModule

public enum ProductFeature {
    public static func makeCoordinator(
        apiClient: APIClient,
        router: AppRouter<AppRoute>
    ) -> ProductCoordinator {
        let builder = ProductFeatureBuilderImpl(apiClient: apiClient, router: router)
        return ProductCoordinatorImpl(builder: builder)
    }
}
