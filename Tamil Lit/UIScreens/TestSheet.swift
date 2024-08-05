//
//  TestSheet.swift
//  Tamil Lit
//
//  Created by Selvarajan on 05/08/24.
//

import SwiftUI

struct TestSheet: View {
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            Button {
                showAlert = true
            } label: {
                Text("Show Alert!")
            }
        }.sheet(isPresented: $showAlert) {
            print("Dismissed")
        } content: {
            Text("Some text")
        }
        
    }
}

#Preview {
    TestSheet()
}
