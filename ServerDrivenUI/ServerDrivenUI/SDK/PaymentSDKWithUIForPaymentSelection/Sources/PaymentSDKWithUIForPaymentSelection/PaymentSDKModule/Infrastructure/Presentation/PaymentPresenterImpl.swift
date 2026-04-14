//
//  PaymentPresenterImpl.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 11/04/26.
//

import SwiftUI
import UIKit

@MainActor
public protocol PaymentPresenter {
    func presentPaymentSheet(_ controller: UIViewController)
    func dismissPaymentSheet()
}

public final class PaymentPresenterImpl: PaymentPresenter {
    
    // Keep weak reference to avoid retain cycles
    private weak var presentedController: UIViewController?
    
    public init() {}
    
    public func presentPaymentSheet(_ controller: UIViewController) {
        
        // 🔥 Razorpay-style bottom sheet
        if let sheet = controller.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        
        controller.modalPresentationStyle = .pageSheet
        
        guard let topVC = topViewController() else {
            print("Unable to find top view controller")
            return
        }
        
        topVC.present(controller, animated: true)
        presentedController = controller
        
    }
    
    public func dismissPaymentSheet() {
        presentedController?.dismiss(animated: true)
        presentedController = nil
    }
}

private extension PaymentPresenterImpl {
    
    func topViewController(
        base: UIViewController? = UIApplication.shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?
            .rootViewController
    ) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            return topViewController(base: tab.selectedViewController)
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}
