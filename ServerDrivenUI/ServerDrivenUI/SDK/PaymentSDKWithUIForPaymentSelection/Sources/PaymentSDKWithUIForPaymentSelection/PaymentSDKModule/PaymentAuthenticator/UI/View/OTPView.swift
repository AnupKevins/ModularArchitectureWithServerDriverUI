//
//  OTPView.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 15/04/26.
//

import SwiftUI

struct OTPView: View {
    
    @State private var otp: String = ""
    
    let onSubmit: (String) -> Void
    let onCancel: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Enter OTP")
                .font(.largeTitle)
                .padding()
            
            TextField("6-digit OTP", text: $otp)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
            
            Button("Submit") {
                onSubmit(otp)
            }
            .buttonStyle(.borderedProminent)
            
            Button("Cancel") {
                onCancel()
            }.foregroundColor(.red)
            Spacer()
            
        }
        .padding()
    }
    
}
