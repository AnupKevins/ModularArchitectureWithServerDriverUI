////
////  PaymentMethodSelectorImpl.swift
////  PaymentSDKWithUIForPaymentSelection
////
////  Created by Anup Sahu on 10/04/26.
////
//
//import Foundation
//import SwiftUI
//
//@MainActor
//final class PaymentMethodSelectorImpl: PaymentMethodSelector {
//    
//    private let presenter: PaymentPresenter
//    // Each viewModel should have
//    private let viewModelFactory: () -> PaymentSheetViewModel
//    
//    init(
//        presenter: PaymentPresenter,
//        viewModelFactory: @escaping () -> PaymentSheetViewModel
//    ) {
//        self.presenter = presenter
//        self.viewModelFactory = viewModelFactory
//    }
//
//    func selectPaymentMethod() async throws -> PaymentSelection {
//        // For Converting Callback into Async Await
//        // 👉 This creates a pause point in async code.
//        
////        The function selectPaymentMethod() suspends here
////        It will resume later manually
////        continuation is like a promise resolver
//        try await withCheckedThrowingContinuation { continuation in
//            
//            let viewModel = viewModelFactory()
//            
//            viewModel.onSelect = { [weak self] option in
//                
//                guard let self else {
//                    continuation.resume(throwing: PaymentSDKError.paymentFailed)
//                    return
//                }
//                
//                let selection = self.mapToSelection(option)
//                
//                self.presenter.dismissPaymentSheet()
//                continuation.resume(returning: selection)
//            }
//            
//            let view = PaymentSheetView(viewModel: viewModel)
//            let controller = UIHostingController(rootView: view)
//            
//            self.presenter.presentPaymentSheet(controller)
//        }
//    }
//    
//    private func mapToSelection(_ option: PaymentOption) -> PaymentSelection {
//        
//        switch option.type {
//            case "UPI":
//                return PaymentSelection(
//                    method: UPIPaymentMethod(),
//                    details: UPIPaymentDetails(
//                        upiId: "abc@upi.in",
//                        upiName: "John"
//                    )
//                )
//                
//            default:
//                return PaymentSelection(
//                    method: CustomPaymentMethod(type: option.type),
//                    details: CustomPaymentDetail(payload: [:])
//                )
//        }
//    }
//}
