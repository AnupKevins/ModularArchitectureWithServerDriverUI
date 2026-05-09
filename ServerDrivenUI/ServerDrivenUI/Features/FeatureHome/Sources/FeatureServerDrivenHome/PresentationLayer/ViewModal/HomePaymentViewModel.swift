//
//  HomePaymentViewModel.swift
//  FeatureHome
//
//  Created by Anup Sahu on 02/04/26.
//

import CoreModule
import Observation

@MainActor
protocol HomePaymentViewModel {
    var statusText: String { get }
    var amountText: String { get set }
    var isLoading: Bool { get }
    
    func makePayment() async
    func makePaymentWithUI() async
}

@Observable
final class HomePaymentViewModelImpl: HomePaymentViewModel {
    
    private let paymentSDKService: PaymentService
    private let paymentUIService: PaymentUIService
    private var task: Task<Void, Never>?
    
    var statusText: String = ""
    var amountText: String = ""
    var isLoading: Bool = false
    
    init(paymentSDKService: PaymentService, paymentUIService: PaymentUIService) {
        self.paymentSDKService = paymentSDKService
        self.paymentUIService = paymentUIService
    }
    
    func makePaymentWithUI() async {
        guard let amount = Double(amountText), amount > 0 else {
            statusText = "Invalid amount"
            return
        }
        
        
        do {
            // 🔥 UI-driven payment flow
            let result = try await paymentUIService.startPayment(amount: amount)
            
            statusText = "Success For SDK UI: \(result.transactionId)"
        } catch {
            statusText = "Failed For SDK UI: \(error.localizedDescription)"
        }
    }
    
    func makePayment() async {
        
        guard let amount = Double(amountText), amount > 0 else {
            statusText = "Please enter a valid amount."
            return
        }
        
        // UPI
        /*let paymentInput = PaymentInput(
            senderId: "UserId123",
            amount: amount,
            instrument: UPIInstrument(
                upiId: "abc@upi.com", upiName: "John"
            )
        )*/
        
        let customPaymentInput = PaymentInput(
            senderId: "customUser123",
            amount: amount,
            instrument: GenericPaymentInstrument(
                methodType: "WALLET",
                metaData: [
                    "walletId": "paytm",
                    "phoneNumber": "7890123456"
            ])
        )
        
        self.isLoading = true
        
        defer {
            self.isLoading = false
        }
        
        do {
            let response = try await paymentSDKService.pay(input: customPaymentInput)
            // task.cancel() → send stop signal
            // Task.isCancelled → check if stop signal received
            // UI may update next line even after:
            // •    user left screen
            // •    task cancelled
            if Task.isCancelled { return }
            
            self.statusText = "Payment successful: \(response.transactionId)"
        } catch {
            
            if Task.isCancelled { return }
            
            self.statusText = "Payment failed: \(error.localizedDescription)"
        }
        
    }
}
