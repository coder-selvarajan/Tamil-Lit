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
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        if let poem = vm.getRandomPoem() {
                            randomPoem = poem
                        }
                    } label: {
                        Text("அடுத்து...")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .padding(.trailing, 15)
                            .background(.yellow)
                            .cornerRadius(10.0)
                            .shadow(radius: 10)
                    }.padding(.trailing, -15)
                }
            }
        }
        .navigationTitle(Text("ஏதோ ஒரு பாடல்"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
//            ToolbarItem(placement: .principal) {
//                HStack {
//                    Text("ஏதோ ஒரு பாடல்")
//                        .font(.body)
//                        .fontWeight(.semibold)
//                    
//                    Spacer()
//                }
//                .padding(0)
//            }
//            
//            ToolbarItem {
//                // Random poem - action button
//                Button {
//                    if let poem = vm.getRandomPoem() {
//                        randomPoem = poem
//                    }
//                } label: {
//                    Text("அடுத்தது")
//                        .font(.body)
//                        .foregroundStyle(.black)
//                        .padding(.horizontal)
//                        .padding(.vertical, 8)
//                        .background(.yellow)
//                        .cornerRadius(5.0)
//                }
//            }
            
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
