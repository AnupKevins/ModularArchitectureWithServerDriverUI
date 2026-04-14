//
//  HomePaymentView.swift
//  FeatureHome
//
//  Created by Anup Sahu on 02/04/26.
//

import SwiftUI

struct HomePaymentView<ViewModel: HomePaymentViewModel>: View {
    
    @State private var viewModel: ViewModel
    @State private var task: Task<Void, Never>?
    
    init(viewModel: ViewModel) {
        self._viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Title
            Text("Make Payment")
                .font(.title)
                .bold()
            
            // Amount
            TextField("Enter amount", text: $viewModel.amountText)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
            
            // Pay Button
            Button {
                
                task?.cancel()
                task = Task {
                    await viewModel.makePayment()
                }
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Text("Pay Without UI").frame(maxWidth: .infinity)
                }
            }
            .disabled(viewModel.isLoading)
            .buttonStyle(.borderedProminent)
            .frame(width: 200)
            
            // Pay Button
            Button {
                
                task?.cancel()
                task = Task {
                    await viewModel.makePaymentWithUI()
                }
            } label: {
                
                Text("Pay With UI").frame(maxWidth: .infinity)
                
            }
            .disabled(viewModel.isLoading)
            .buttonStyle(.borderedProminent)
            .frame(width: 200)
            
            Text(viewModel.statusText)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .onDisappear {
            task?.cancel()
        }
    }
}
