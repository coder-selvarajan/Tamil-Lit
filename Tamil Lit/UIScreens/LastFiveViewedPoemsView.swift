//
//  LastFiveViewedPoemsView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 14/08/24.
//

import SwiftUI

struct LastFiveViewedPoemsView: View {
    @EnvironmentObject var bookManager: BookManager
    @StateObject private var vm = LastViewedPoemsViewModel()
    
    var body: some View {
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
                ForEach(vm.lastFiveViewedPoems ?? [], id: \.id) { poem in
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
                            .foregroundStyle(.black)
                        }
                        
                        Divider()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemBackground))
                    .onTapGesture {
                        // Handle tap gesture if needed
                    }
                    
                }
                
                Text("View all recent poems  ⇾ ")
                    .font(.subheadline.bold())
                    .padding([.vertical, .leading], size10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
//            ForEach(vm.lastFiveViewedPoems ?? [], id: \.id) { poem in
//                
//                VStack(alignment: .leading) {
//                    Text("\(String(describing: poem.bookname)) - \(poem.number)")
//                    Text(poem.poem ?? "")
//                        .lineLimit(3)
//                }
//                .onTapGesture {
//                    //                        selectedPoem = poem
//                    //                        isShowingDetail = true
//                }
//            }
            
        }
        .padding()
        .onAppear() {
            vm.getLastThreeViewedPoems()
        }
    }
}
