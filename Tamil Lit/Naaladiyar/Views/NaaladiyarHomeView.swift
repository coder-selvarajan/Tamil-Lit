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
        NaaladiyarCategoryView(poems: nil, categories: vm.loadNaaladiyarCategoryData())
    }
}

#Preview {
    NaaladiyarHomeView()
}
