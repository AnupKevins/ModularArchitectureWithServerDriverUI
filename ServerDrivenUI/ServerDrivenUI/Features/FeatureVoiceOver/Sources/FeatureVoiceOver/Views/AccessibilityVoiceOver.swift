// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

struct AccessibilityVoiceOver: View {
    
    @State private var isActive: Bool = true
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Preferences")) {
                    Toggle("Volume", isOn: $isActive)
                    
                    HStack {
                        Text("Volume")
                        
                        Spacer()
                        Text("\(isActive ? "ON" : "OFF")")
                    }
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        isActive.toggle()
                    }
                }
                
                Section(header: Text("APPLICATION")) {
                    Button("Favourites") {
                        
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "heart.fill")
                    }
                    
                    Text("Favourites")
                        .onTapGesture {
                            
                        }
                }
                
                VStack {
                    Text("CONTENT")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.secondary)
                        .font(.caption)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            
                            ForEach(0..<10) { index in
                                VStack {
                                    Image("parrot", bundle: .module)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                    
                                    Text("Item \(index)")
                                }
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
}

#Preview {
    AccessibilityVoiceOver()
}
