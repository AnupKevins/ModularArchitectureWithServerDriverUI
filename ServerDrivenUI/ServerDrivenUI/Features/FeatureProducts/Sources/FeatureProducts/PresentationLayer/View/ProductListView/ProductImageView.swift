//
//  ProductImageView.swift
//  FeatureProducts
//
//  Created by Anup Sahu on 26/03/26.
//

import SwiftUI
import CoreModule

struct ProductImageView: View {
    
    let url: URL
    let imageLoader: ImageLoader
    
    @State private var image: UIImage?
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
            }
        }
        .frame(width: 60, height: 60)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .task {
            await loadImage()
        }
    }
    
    private func loadImage() async {
        do {
            image = try await imageLoader.loadImage(from: url)
        } catch {
            print("Image load failed", error)
        }
        
    }
    
}
