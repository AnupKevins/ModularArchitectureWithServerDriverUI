//
//  PaymentDetails.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 10/05/26.
//

enum PaymentDetails: Sendable {
    case wallet(walletId: String, authToken: String)
    case upi(upiId: String)
    case card(cardNumber: String, cvv: String, expiry: String)
    case neft(ifsc: String, accountNumber: String)
}

extension PaymentDetails {
    
    func toDictionary() -> [String: Any] {
        switch self {
            case .wallet(let walletId, let authToken):
                return [
                    "walletId": walletId,
                    "authToken": authToken
                ]
                
            case .upi(upiId: let upi):
                return [
                    "upiId": upi
                ]
                
            case .card(let cardNumber, let cvv, let expiry):
                return [
                    "cardNumber": cardNumber,
                    "cvv": cvv,
                    "expiry": expiry
                ]
            case .neft(let ifsc, let accountNumber):
                return [
                    "ifsc": ifsc,
                    "accountNumber": accountNumber
                ]
        }
    }
}
