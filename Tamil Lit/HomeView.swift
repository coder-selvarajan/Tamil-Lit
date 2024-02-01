//
//  HomeView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 01/02/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(value: "Thirukural") {
                    HStack {
                        Text("📘")
                            .font(.system(size: 40))
                            .padding(.trailing, 15)
                        
                        Text("திருக்குறள்")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(.black)
                            .padding(.vertical, 15)
                        
                        Spacer()
                    }
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(15.0)
                    .padding(.bottom, 10)
                }
                
                NavigationLink(value: "Athichudi") {
                    HStack {
                        Text("📗")
                            .font(.system(size: 40))
                            .padding(.trailing, 15)
                        
                        Text("ஆத்தி சூடி")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(.black)
                            .padding(.vertical, 15)
                        
                        Spacer()
                    }
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(15.0)
                    .padding(.bottom, 10)
                }
                
                Spacer()
            }
            .padding(20)
            .preferredColorScheme(.light)
            .navigationBarTitle("Tamil Lit")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: String.self) { value in
                if value == "Thirukural" {
                    KuralHomeView()
                } else if value == "Athichudi" {
                    AthichudiHomeView()
                }
            }
        } // NavigationStack
        
    }
}

#Preview {
    HomeView()
}
