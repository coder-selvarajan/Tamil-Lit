//
//  BookSelectorView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 21/07/24.
//

import SwiftUI

struct BookSelectorView: View {
    @Binding var showModal: Bool
    @Binding var booksInfo: [BookInfo]
    
    var title: AttributedString = ""
    var subTitle: AttributedString = ""
    
    let closeCallBack: (() -> Void)?
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.body)
                        if subTitle != "" {
                            Text(subTitle)
                                .font(.body)
                        }
                    }
                    .padding(.bottom, paddingSize)
                    
                    ForEach($booksInfo, id:\.id) { $bookInfo in
                        VStack {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.title3)
                                    .foregroundColor(bookInfo.selected ? .yellow : .gray.opacity(0.5))
                                    .padding(.trailing)
                                
                                Text(bookInfo.title)
                                    .foregroundColor(bookInfo.selected ? Color("TextColor") : .gray.opacity(0.7))
                                Spacer()
                            }
                            Divider().padding(.bottom, 5)
                        }
                        .padding(.horizontal, 10)
                        .onTapGesture {
                            bookInfo.selected.toggle()
                            
                            closeCallBack!()
                        }
                    }
                    
                } //VStack
                .padding(paddingSize)
                .background(Color("TextColorWhite"))
                .foregroundColor(Color("TextColor"))
                .cornerRadius(15)
                .frame(width: UIScreen.main.bounds.size.width - 60)
                .overlay(
                    CloseButton() {
                        showModal = false
                    }, alignment: .topTrailing
                )
            }
        } // ZStack
    }
}

struct CloseButton: View {
    var closeButtonClicked : () -> Void
    
    var body: some View {
        Button {
            closeButtonClicked()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.red.opacity(0.8))
        }
        .padding([.top, .trailing], 10)
    }
}

//#Preview {
//    BookSelectorView()
//}
