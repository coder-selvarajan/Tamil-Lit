//
//  LastFiveViewedPoemsView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 14/08/24.
//

import SwiftUI

struct LastThreeViewedPoemsView: View {
    @EnvironmentObject var bookManager: BookManager
    @StateObject private var vm = LastViewedPoemsViewModel()
    
    var body: some View {
        ZStack {
            if let viewedPoems = vm.lastThreeViewedPoems, viewedPoems.count > 0 {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "clock")
                            .font(.title2)
                            .padding(.trailing, 5)
                        Text("சமீபத்தில் படித்தவை")
                            .font(.title3)
                        
                        Spacer()
                    }
                    .padding(.bottom, size10)
                    
                    Divider()
                    
                    //Results
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(vm.lastThreeViewedPoems ?? [], id: \.id) { poem in
                            VStack(alignment: .leading) {
                                NavigationLink(destination: PoemDetailWrapperView(selectedPoem: poem))
                                {
                                    VStack(alignment: .leading) {
                                        Text("\(poem.bookname ?? "") - \(poem.book?.poemType ?? "") \(poem.number)")
                                            .font(.headline)
                                            .padding(.leading, size10)
                                        
                                        Text(poem.poem ?? "")
                                            .lineLimit(3)
                                            .multilineTextAlignment(TextAlignment.leading)
                                            .padding(.leading, size10)
                                    }
                                    .foregroundStyle(Color("TextColor"))
                                }
                                
                                Divider()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemBackground))
                            .onTapGesture {
                                // Handle tap gesture if needed
                            }
                        }
                        
                        NavigationLink(destination: LastViewedPoemListView()) {
                            Text("View all recent poems  ⇾ ")
                                .font(.subheadline.bold())
                                .foregroundStyle(Color("TextColor"))
                                .padding([.vertical, .leading], size10)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            } else {
                EmptyView()
            }
        }
        .onAppear() {
            vm.getLastThreeViewedPoems()
        }
    }
}
