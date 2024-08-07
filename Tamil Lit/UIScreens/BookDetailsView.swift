//
//  BookDetailsView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 22/07/24.
//

import SwiftUI

struct BookDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var vm = BookDetailsViewModel()
    
    @EnvironmentObject var bookManager: BookManager
    @EnvironmentObject var themeManager: ThemeManager
    
    @State var popupMode: Bool = true
    
    var bookName: String = "திருக்குறள்"
    var bookInfo: BookInfo {
        bookManager.books.filter({$0.title == bookName}).first!
    }
    
    func getReadableText(from bookObj: Book?) -> String {
        var author = ""
        var period = ""
        
        guard let book = bookObj else { return "" }
        
        if let _author = vm.book?.author, _author != "" {
            author = "எழுதியவர்: \(_author)"
        }
        if let _period = vm.book?.period, _period != "" {
            period = "காலம்: \(_period)"
        }
        
        return """
            \(bookInfo.title)
            \(bookInfo.subtitle)
            
            \(author)
            \(period)
            
            \(book.info ?? "")
            """
    }
    
    var body: some View {
        ZStack {
            if themeManager.selectedTheme == ThemeSelection.primary {
                bookInfo.color.opacity(0.2).ignoresSafeArea()
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: size10) {
                    
                    HStack(alignment: .top) {
                        Image(bookInfo.image)
                            .resizable()
                            .scaledToFit()
                            .saturation(themeManager.selectedTheme == ThemeSelection.primary ?  0.1 : 1.0)
                            .opacity(0.75)
                            .frame(width: size60)
                            .padding(.trailing, size10)
                        
                        VStack(alignment: .leading) {
                            Text(bookName)
                                .textSelection(.enabled)
                                .font(.title3.bold())
                            Text(bookInfo.subtitle)
                                .textSelection(.enabled)
                                .font(.subheadline.bold())
                            
                            if vm.book?.author! != "" || vm.book?.period! != "" {
                                Divider()
                                    .background(Color("TextColor"))
                                    .padding(.bottom, 5)
                            }
                            
                            VStack(alignment: .leading) {
                                if let author = vm.book?.author, author != "" {
                                    Text("எழுதியவர்: \(author)").textSelection(.enabled)
                                }
                                if let period = vm.book?.period, period != "" {
                                    Text("காலம்: \(period)").textSelection(.enabled)
                                }
                            }
                            .font(.subheadline.bold())
                        }
                        Spacer()
                    }
                    .padding()
                    .padding(.vertical)
                    .background(themeManager.selectedTheme == .primary
                                ? bookInfo.color.opacity(0.2) : .gray.opacity(0.1))
                    
                    HStack {
                        Spacer()
                        
                        SpeakButtonView(textContent:
                                            Binding(
                                                get: { getReadableText(from: vm.book) },
                                                set: { newValue in
                                                    //
                                                }))
                        .padding([.vertical, .trailing], 5)
//                            .background(themeManager.selectedTheme == .primary ? .gray.opacity(0.3) : .gray.opacity(0.2))
//                            .cornerRadius(8)
                    }

                    // book description
                    Text(vm.book?.info ?? "")
                        .textSelection(.enabled)
                        .padding([.horizontal, .bottom], size20)
                }
            }
            
            if popupMode {
                VStack {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "xmark.app.fill")
                            .font(.largeTitle)
                            .foregroundColor(themeManager.selectedTheme == .primary
                                             ? .black.opacity(0.60) : .red.opacity(0.9))
                            .padding(size10)
                            .padding(.top, 5)
                            .onTapGesture {
                                presentationMode.wrappedValue.dismiss()
                            }
                    }
                    
                    Spacer()
                }
                .customFontScaling()
            }
        }
        .customFontScaling()
        .onAppear() {
            vm.getBookInfo(bookName: bookName)
        }
    }
}

//#Preview {
//    BookDetailsView()
//}
