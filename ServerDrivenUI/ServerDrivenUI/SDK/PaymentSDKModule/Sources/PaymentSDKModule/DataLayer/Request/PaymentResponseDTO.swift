//
//  PaymentResponseDTO.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 31/03/26.
//

struct PaymentResponseDTO: Decodable {
    let transactionId: String
    let status: String
}
