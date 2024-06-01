//
//  NaaladiyarHomeView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 24/03/24.
//

import SwiftUI

struct NaaladiyarHomeView: View {
    var vm: NaaladiyarViewModel = NaaladiyarViewModel()
    var body: some View {
        ZStack {
            Color.indigo.opacity(0.2).ignoresSafeArea()
            
            NaaladiyarCategoryView(poems: vm.loadNaaladiyarData(), categories: vm.loadNaaladiyarCategoryData())
        }
    }
}

#Preview {
    NaaladiyarHomeView()
}
