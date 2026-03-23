//
//  HomeView\.swift
//  FeatureHome
//
//  Created by Anup Sahu on 03/03/26.
//

import SwiftUI

public struct ProductView: View {
    
    @StateObject private var viewModel: ProductViewModel
    // here coordinator creates the Viewmodel so use @ObservedObject
    @State private var offset: CGFloat = 0
    
    init(viewModel: ProductViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        
        GeometryReader { geo in
            VStack {
                
                HeaderView()
                    .opacity(offset > 100 ? 0 : 1)
                
                
                List {
                    
                        ForEach(viewModel.products, id: \.id) { product in
                            ProductRow(product: product, width: geo.size.width)
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        viewModel.deleteProduct(product)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }

                                }
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
        .task {
            await viewModel.fetchProducts()
        }
        .navigationTitle("Product")
    }
}
