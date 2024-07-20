//
//  RandomPoemView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 19/07/24.
//

import SwiftUI

struct RandomPoemView: View {
    @StateObject private var vm = SimplePoemDetailViewModel()
    @State var randomPoem: Poem?
    
    var body: some View {
        ZStack {
            SimplePoemDetailView(selectedPoem: $randomPoem)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("ஏதோ ஒரு பாடல்")
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                .padding(0)
            }
            
            ToolbarItem {
                // Random poem - action button
                Button {
                    if let poem = vm.getRandomPoem() {
                        randomPoem = poem
                    }
                } label: {
                    Text("அடுத்தது")
                        .font(.body)
                        .foregroundStyle(.black)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(.yellow)
                        .cornerRadius(5.0)
                }
            }
            
            ToolbarItem {
                Image(systemName: "gearshape")
            }
        }
        .onAppear {
            if let poem = vm.getRandomPoem() {
                randomPoem = poem
            }
        }
    }
}

#Preview {
    RandomPoemView()
}
