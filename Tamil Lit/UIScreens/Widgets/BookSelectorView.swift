//
//  BookSelectorView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 21/07/24.
//

import SwiftUI

struct BookSelectorView: View {
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var themeManager: ThemeManager
    
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
                    .padding(.bottom, size20)
                    
                    ForEach($booksInfo, id:\.id) { $bookInfo in
                        VStack {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.title3)
                                    .foregroundColor(bookInfo.selected ? .orange.opacity(0.7) : .gray.opacity(0.5))
                                    .padding(.trailing)
                                
                                Text(bookInfo.title)
                                    .foregroundColor(bookInfo.selected ? Color("TextColor") : .gray.opacity(0.7))
                                Spacer()
                            }
                            Divider().padding(.bottom, 5)
                        }
                        .accessibilityElement(children: .combine)
                        .accessibilityAddTraits(.isButton)
                        .accessibilityLabel(Text("Book Selector - \(bookInfo.title) - \(bookInfo.selected) "))
                        .accessibilityIdentifier("\(bookInfo.title)")
                        .padding(.horizontal, size10)
                        .onTapGesture {
                            bookInfo.selected.toggle()
                            
                            closeCallBack!()
                        }
                    }
                    
                } //VStack
                .padding(size20)
                .background(userSettings.darkMode ? .black : .white)
                .foregroundColor(Color("TextColor"))
                .cornerRadius(size15)
                .frame(width: UIScreen.main.bounds.size.width - size60)
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
            Image(systemName: "xmark.app.fill")
                .resizable()
                .frame(width: size30, height: size30)
                .foregroundColor(.red.opacity(0.9))
        }
        .padding([.top, .trailing], size10)
    }
}

//#Preview {
//    BookSelectorView()
//}
