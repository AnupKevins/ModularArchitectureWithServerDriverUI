//
//  PaymentOptionView.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 02/05/26.
//

import SwiftUI

struct PaymentOptionView: View {
    
    let options: [PaymentOption]
    let onSelect: (PaymentOption) -> Void
    let onCancel: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Select Payment Method")
                .font(.headline)
            
            ForEach(options, id: \.type) { option in
                Button(option.title, action: { onSelect(option)
                })
            }
            
            Button("Cancel") {
                onCancel()
            }
        }
    }
}
