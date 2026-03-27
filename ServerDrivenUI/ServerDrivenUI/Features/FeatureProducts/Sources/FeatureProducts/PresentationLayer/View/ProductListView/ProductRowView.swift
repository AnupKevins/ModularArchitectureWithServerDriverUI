//
//  ProductRowView.swift
//  FeatureProducts
//
//  Created by Anup Sahu on 26/03/26.
//

import SwiftUI

struct ProductRowView: View {
    
    let product: Product
    let onDelete: (Product) -> Void
    
    @Environment(\.imageLoader) private var imageLoader
    
    var body: some View {
        
        HStack(spacing: 12) {
            if let url = URL(string: product.image),
               let imageLoader {
                ProductImageView(url: url, imageLoader: imageLoader)
            }
            
            ProductRow(product: product)
        }
        .swipeActions {
            Button(role: .destructive) {
                onDelete(product)
            } label: {
                Label("Delete", systemImage: "trash")
            }
            
        }
        
            
    }
    
}
