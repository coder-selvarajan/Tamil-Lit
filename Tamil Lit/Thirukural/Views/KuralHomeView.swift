//
//  HomeView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import SwiftUI

struct KuralHomeView: View {
    var vm: KuralViewModel = KuralViewModel()
    var body: some View {
        ZStack {
            Color.blue.opacity(0.2).ignoresSafeArea()
            
            KuralCategoryView(sections: vm.loadKuralCategoryData(), kuralList: vm.loadKuralData())
        }
    }
}

#Preview {
    KuralHomeView()
}
