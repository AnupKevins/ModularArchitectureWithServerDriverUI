//
//  PaymentMethodInput.swift
//  CoreModule
//
//  Created by Anup Sahu on 02/04/26.
//

import PaymentSDKModule

public protocol PaymentInstrument {
    func toSDK() -> SDKMapping
}
