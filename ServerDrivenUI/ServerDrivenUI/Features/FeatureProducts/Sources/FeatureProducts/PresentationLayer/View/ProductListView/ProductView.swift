//
//  HomeView\.swift
//  FeatureHome
//
//  Created by Anup Sahu on 03/03/26.
//

import SwiftUI

struct ProductView<ViewModel: ProductViewModel>: View {
    
    @State private var viewModel: ViewModel
    // here coordinator creates the Viewmodel so use @ObservedObject
    @State private var offset: CGFloat = 0
    
    init(viewModel: ViewModel) {
        self._viewModel = State(wrappedValue: viewModel)
    }
    
    public var body: some View {
        
        GeometryReader { geo in
            VStack {
                
                HeaderView()
                    .opacity(offset > 100 ? 0 : 1)
                
                List {
                    ForEach(viewModel.products) { product in
                        ProductRowView(
                            product: product,
                            width: geo.size.width,
                            onDelete: viewModel.deleteProduct
                        )
                    }
                    
                }
                .onScrollGeometryChange(for: CGFloat.self) { geometry in
                    geometry.contentOffset.y
                } action: { oldValue, newValue in
                    offset = newValue
                    print("Scroll progress:", newValue)
                }
            }
        }
        .navigationTitle("Product")
        .task {
            await viewModel.fetchProducts()
        }
        
    }
}
