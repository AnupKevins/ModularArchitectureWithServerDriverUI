//
//  HomeView\.swift
//  FeatureHome
//
//  Created by Anup Sahu on 03/03/26.
//

import SwiftUI
import ServerDrivenEngine
import CoreModule

struct HomeView<ViewModel: HomeViewModel>: View {
    
    @State private var viewModel: ViewModel
    
    @Environment(\.homeNavigator) private var homeNavigator
    
    init(viewModel: ViewModel) {
        self._viewModel = State(wrappedValue: viewModel)
    }
    
    public var body: some View {
        print("@@@ HomeView body")
       return ScrollView {
            ForEach(viewModel.components, id: \.id) { component in
                ServerDrivenRenderer(components: [component])
                Text("\(component.type)")
            }
            Button("Navigate to product") {
                homeNavigator?.openProductList()
            }
           Spacer()
           Button("Navigate to Voice over") {
               homeNavigator?.openVoiceOver()
           }
           Spacer()
           Button("Navigate to Home Payment") {
               // For Deeplink use Global Navigator
               // For Simple use navigationDestination(...)
               homeNavigator?.openPayment()
           }
           // For Simple use navigationDestination(...)
//           .navigationDestination(isPresented: $showPayment) {
//               PaymentView(...)
//           }
        }.task {
            await viewModel.fetchHomeComponents()
        }.onChange(of: viewModel.components.count) { newValue in
            print("New Value: \(newValue)")
        }.navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
    }
}
