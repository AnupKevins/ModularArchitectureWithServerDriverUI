// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

struct AccessibilityVoiceOver: View {
    
    @State private var isActive: Bool = true
    
    var body: some View {
        
            Form {
                Section(header: Text("Preferences")) {
                    Toggle("Volume", isOn: $isActive)
                    
                    HStack {
                        Text("Volume")
                        
                        Spacer()
                        Text("\(isActive ? "ON" : "OFF")")
                            .accessibilityHidden(true)
                    }
                    .background(Color.black.opacity(0.001))
                    // When we click on the tap gesture, in voice over it dont say toggle on off just like above volume toggle
                    .onTapGesture {
                        isActive.toggle()
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityAddTraits(.isButton)
                    .accessibilityValue(isActive ? "is ON" : "is OFF")
                    .accessibilityHint("Double tap to toggle settings")
                    .accessibilityAction {
                        isActive.toggle()
                    }
                }
                
                Section(header: Text("APPLICATION")) {
                    Button("Favourites") {
                        
                    }
                    .accessibilityRemoveTraits(.isButton)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "heart.fill")
                    }
                    .accessibilityLabel("Favourites")
                    Text("Favourites")
                        .accessibilityAddTraits(.isButton)
                        .onTapGesture {
                            
                        }
                }
                
                VStack {
                    Text("CONTENT")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.secondary)
                        .font(.caption)
                        .accessibilityAddTraits(.isHeader)
                    
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
                                .onTapGesture {
                                    
                                }
                                .accessibilityElement(children: .combine)
                                .accessibilityAddTraits(.isButton)
                                .accessibilityLabel("Item \(index). Image of parrot")
                                .accessibilityHint("Double tap to open")
                                
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
