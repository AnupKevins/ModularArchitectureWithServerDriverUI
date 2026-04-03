//
//  PaymentInput.swift
//  CoreModule
//
//  Created by Anup Sahu on 03/04/26.
//

public struct PaymentInput {
    
    public let senderId: String
    public let amount: Double
    public let instrument: PaymentInstrument
    
    public init(senderId: String, amount: Double, instrument: PaymentInstrument) {
        self.senderId = senderId
        self.amount = amount
        self.instrument = instrument
    }
}
