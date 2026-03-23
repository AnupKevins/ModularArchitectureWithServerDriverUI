//
//  ProductRow.swift
//  FeatureProducts
//
//  Created by Anup Sahu on 04/03/26.
//

import SwiftUI

struct ProductRow: View {
    
    let product: Product
    let width: CGFloat
    
    var body: some View {
        Text(product.title)
            .modifier(
                TitleViewModifier(fontSize: width)
            )
    }
}
