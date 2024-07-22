//
//  FavouritePoemListView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 22/07/24.
//

import SwiftUI

struct FavouritePoemListView: View {
    @StateObject private var vm = FavouritePoemViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(vm.favPoems, id:\.id) { favPoem in
                        Text("\(favPoem.bookname ?? "") - \(favPoem.poem ?? "")")
                    }
                }
                
            }
        }
        .navigationTitle("Favourite Poems")
        .onAppear(){
            vm.getAllFavPoems()
        }
    }
}

#Preview {
    FavouritePoemListView()
}
