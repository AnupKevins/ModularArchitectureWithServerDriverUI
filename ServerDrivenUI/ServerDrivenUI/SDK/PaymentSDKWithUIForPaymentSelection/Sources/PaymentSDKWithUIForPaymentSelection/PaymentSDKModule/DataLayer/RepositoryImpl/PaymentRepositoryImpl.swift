//
//  PaymentRepositoryImpl.swift
//  PaymentSDKModule
//
//  Created by Anup Sahu on 31/03/26.
//

final class PaymentRepositoryImpl: PaymentRepository {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func makePayment(request: PaymentRequestModel) async throws -> PaymentResponse {
        // no need to mock PaymentAPIRequest as it is just a creation of api request
        let paymentApiRequest = PaymentAPIRequest(request: request)
        
        let dto = try await networkClient.request(paymentApiRequest)
        
        print("@@@ dto", dto)
        
        return PaymentResponse(
            transactionId: dto.transactionId,
            status: mapStatus(dto.status)
        )
        
    }
    
    func validateWalletOTP(otp: String) async throws -> String {
        // simulate API
        guard otp == "1234" else {
            throw PaymentSDKError.authenticationFailed
        }
        
        return "secure_token_123"
    }
    
    private func mapStatus(_ status: String) -> PaymentStatus {
        switch status {
            case "success":
                return .success
            case "pending":
                return .pending
            default:
                return .failed
        }
    }
}
