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
    private let router: AppRouter<AppRoute>
    
    init(viewModel: ViewModel, router: AppRouter<AppRoute>) {
        self._viewModel = State(wrappedValue: viewModel)
        self.router = router
    }
    
    public var body: some View {
        ScrollView {
            ForEach(viewModel.components, id: \.id) { component in
                ServerDrivenRenderer(components: [component])
                Text("\(component.type)")
            }
            Button("Navigate to product") {
                router.push(route: .productListRoute)
            }
        }.task {
            await viewModel.fetchHomeComponents()
        }.onChange(of: viewModel.components.count) { newValue in
            print("New Value: \(newValue)")
        }.navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
    }
}
