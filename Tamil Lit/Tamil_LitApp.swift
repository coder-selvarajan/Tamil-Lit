//
//  Tamil_LitApp.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import SwiftUI
import SwiftData

@main
struct Tamil_LitApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                VStack {
                    NavigationLink(destination: KuralHomeView()) {
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
//                        .padding()
                    }
                    
                    NavigationLink(destination: AthichudiHomeView()) {
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
//                        .padding()
                    }
                    
                    Spacer()
                }
                .padding(20)
                .navigationBarTitle("Tamil Lit")
                .navigationBarTitleDisplayMode(.inline)
            }.preferredColorScheme(.light)
        }
    }
}
