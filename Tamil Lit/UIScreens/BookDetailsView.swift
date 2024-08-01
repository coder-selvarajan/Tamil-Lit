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
    @State var popupMode: Bool = true
    var bookName: String = "திருக்குறள்"
    var bookInfo: BookInfo {
        _books.filter({$0.title == bookName}).first!
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            bookInfo.color.opacity(0.2).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: size10) {
                    
                    HStack(alignment: .top) {
                        Image(bookInfo.image)
                            .resizable()
                            .scaledToFit()
                            .saturation(0.0)
                            .opacity(0.75)
                            .frame(width: size60)
                            .padding(.trailing, size10)
                        
                        VStack(alignment: .leading) {
                            Text(bookName)
                                .font(.title3)
                                .fontWeight(.bold)
                            Text(bookInfo.subtitle)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            if vm.book?.author! != "" || vm.book?.period! != "" {
                                Divider()
                                    .background(.black)
                                    .padding(.bottom, 5)
                            }
                            
                            VStack(alignment: .leading) {
                                if let author = vm.book?.author, author != "" {
                                    Text("எழுதியவர் : \(author)")
                                }
                                if let period = vm.book?.period, period != "" {
                                    Text("காலம் : \(period)")
                                }
                            }
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        }
                        .foregroundStyle(.black)
                        Spacer()
                    }
                    .padding()
                    .padding(.vertical)
                    .background(bookInfo.color.opacity(0.3))

                    // book description
                    Text(vm.book?.info ?? "")
                        .padding(size20)
                        .foregroundStyle(.black)
                }
                
            }
            .onAppear() {
                vm.getBookInfo(bookName: bookName)
            }
            
            if popupMode {
                VStack {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "xmark.app.fill")
                            .font(.largeTitle)
                            .foregroundColor(.black.opacity(0.60))
                            .padding(size10)
                            .padding(.top, 5)
                            .onTapGesture {
                                presentationMode.wrappedValue.dismiss()
                            }
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

//#Preview {
//    BookDetailsView()
//}
