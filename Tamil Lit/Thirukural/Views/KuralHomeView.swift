//
//  HomeView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import SwiftUI

struct KuralHomeView: View {
//    var vm: KuralViewModel = KuralViewModel()
//    
//    var body: some View {
//        KuralListView(kuralData: vm.loadKuralData())
//    }
    
    var vm: KuralViewModel = KuralViewModel()
    
    
    
    var body: some View {
        KuralCategoryView(sections: vm.loadKuralCategoryData(), kuralList: vm.loadKuralData())
    }
}

#Preview {
    KuralHomeView()
}
