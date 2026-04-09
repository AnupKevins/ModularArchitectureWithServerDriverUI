//
//  PaymentPresenter.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 09/04/26.
//

import SwiftUI

public protocol PaymentPresenter {
    func presentPaymentSheet(_ view: AnyView)
    func dismissPaymentSheet()
}

