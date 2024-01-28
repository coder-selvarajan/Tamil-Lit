//
//  HomeView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import SwiftUI

struct HomeView: View {
    var vm: ThirukuralViewModel = ThirukuralViewModel()
    
    var body: some View {
        KuralListView(kuralData: vm.loadKuralData())
    }
}

//#Preview {
//    HomeView()
//}
