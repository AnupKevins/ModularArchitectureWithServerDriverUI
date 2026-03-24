//
//  ProductFeature.swift
//  FeatureProducts
//
//  Created by Anup Sahu on 23/03/26.
//
import CoreModule

public enum ProductFeature {
    public static func makeCoordinator(
        apiClient: APIClient
    ) -> ProductCoordinator {
        let builder = ProductFeatureBuilderImpl(apiClient: apiClient)
        return ProductCoordinatorImpl(builder: builder)
    }
}
