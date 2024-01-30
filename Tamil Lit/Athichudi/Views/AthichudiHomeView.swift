//
//  HomeView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import SwiftUI

struct AthichudiHomeView: View {
    var vm: AthichudiViewModel = AthichudiViewModel()
    
    var body: some View {
        AthichudiListView(athichudiData: vm.loadAthichudiData())
    }
}

#Preview {
    AthichudiHomeView()
}
