//
//  PaymentOption.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 09/04/26.
//

import Foundation

struct PaymentOption: Identifiable {
    let id = UUID()
    let title: String
    let type: String
}
