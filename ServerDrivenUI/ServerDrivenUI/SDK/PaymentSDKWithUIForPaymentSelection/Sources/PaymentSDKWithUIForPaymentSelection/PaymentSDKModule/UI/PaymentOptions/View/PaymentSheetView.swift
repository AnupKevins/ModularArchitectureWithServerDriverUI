//
//  PaymentSheetView.swift
//  PaymentSDKWithUIForPaymentSelection
//
//  Created by Anup Sahu on 09/04/26.
//

import SwiftUI

struct PaymentSheetView: View {
    
    @State private var viewModel: PaymentSheetViewModel
    
    init(viewModel: PaymentSheetViewModel) {
        self._viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            
            if viewModel.isLoading {
                ProgressView()
            }
            
            List(viewModel.options, id: \.id) { option in
                Button(option.title) {
                    viewModel.didSelect(option)
                }
                
            }
        }
        .task {
            await viewModel.loadOptions()
        }
        .padding()
    }
}
