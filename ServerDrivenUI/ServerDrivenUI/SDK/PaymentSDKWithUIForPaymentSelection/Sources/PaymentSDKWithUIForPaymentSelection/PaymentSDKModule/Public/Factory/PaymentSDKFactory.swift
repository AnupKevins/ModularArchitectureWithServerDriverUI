//
//  PaymentSDKFactory.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 21/04/26.
//

@MainActor
public enum PaymentSDKFactory {
    
    public static func makeUIService(
        config: PaymentUIConfig
    ) -> PaymentSDKUIService {
        
        let dependencyFactory = InternalDependencyFactory(
            config: config
        )
        
        return dependencyFactory.makePaymentSDKUIService()
    }
}

