//
//  PaymentPresenterImpl.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 11/04/26.
//

import SwiftUI
import UIKit

@MainActor
public protocol PaymentPresenter: Sendable {
    func presentPaymentSheet(_ controller: UIViewController)
    func dismissPaymentSheet(completion: @escaping () -> Void)
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
    
    public func dismissPaymentSheet(completion: @escaping () -> Void) {
        
        /// 🔥 If nothing is presented -> complete immediately
        guard let controller = presentedController else { completion();
            return
        }
        
        /// 🔥 Important: use UIKIT completion block
        controller.dismiss(animated: true) {
            
            /// 🔥 Clear reference to presented controller to avoid memory leaks
            self.presentedController = nil
            
            /// 🔥 notify caller that dismissal is finished
            completion()
        }
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
