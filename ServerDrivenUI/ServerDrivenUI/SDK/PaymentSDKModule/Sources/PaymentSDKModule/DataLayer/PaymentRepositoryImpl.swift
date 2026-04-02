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
        
        return PaymentResponse(transactionId: dto.transactionId, status: mapStatus(dto.status))
        
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
