//
//  PoemScreenshotView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 25/07/24.
//

import SwiftUI

struct PoemScreenshotView: View {
    @Binding var poem: Poem
    @Binding var explanations: [Explanation]
    @State var iconTintColor: Color
    
    let colorTheme: Color
    let completionCallBack: (() -> Void)?
    
    func getCategoryText() -> String {
        if poem.sectionname != nil {
            return "\(poem.maincategoryname ?? "")  ›  \(poem.subcategoryname ?? "")  ›  \(poem.sectionname ?? "")"
        } else if poem.subcategoryname != nil {
            return "\(poem.maincategoryname ?? "")  ›  \(poem.subcategoryname ?? "")"
        } else {
            return "\(poem.maincategoryname ?? "")"
        }
    }
    
    func getPoemTitle() -> String {
        if poem.number == 0 {
            return ""
        }
        let poemType = poem.book?.poemType ?? ""
        if let title = poem.title, title != "" {
            return title + ":"
        }
        return poemType + ": \(poem.number)"
    }
    
    var getPoemScreenshotView: some View {
        VStack(alignment: .leading, spacing: size10) {
            HStack(alignment: .top, spacing: 5) {
                Text("நூல் : ")
                    .padding(3)
                    .foregroundStyle(Color("TextColor"))
                    .frame(width: size60)
                    .multilineTextAlignment(.trailing)
                    .background(Color("TextColorWhite"))
                    .cornerRadius(5)
                    .padding(.trailing, 5)
                Text("\(poem.bookname ?? "")")
                    .fontWeight(.bold)
                    .foregroundStyle(.black.opacity(0.95))
                Spacer()
            }
            .font(.subheadline)
            .padding(.vertical)
            .padding(.leading, size20)
            .padding(.trailing, 5)
            
            if !getCategoryText().starts(with: "பாடல்") {
                HStack(alignment: .top, spacing: 5) {
                    Text("வகை : ")
                        .padding(3)
                        .foregroundStyle(Color("TextColor"))
                        .frame(width: size60)
                        .multilineTextAlignment(.trailing)
                        .background(Color("TextColorWhite"))
                        .cornerRadius(5)
                        .padding(.trailing, 5)
                    Text("\(getCategoryText())")
                        .fontWeight(.bold)
                        .foregroundStyle(Color("TextColor").opacity(0.95))
                    Spacer()
                }
                .font(.subheadline)
                .padding(.bottom)
                .padding(.leading, size20)
                .padding(.trailing, 5)
            }
            
            // Poem view
            VStack(alignment: .leading, spacing: size10) {
                Text("\(getPoemTitle())")
                    .font(.callout)
                    .fontWeight(Font.Weight.semibold)
                    .foregroundStyle(Color("TextColor"))
                
                VStack(alignment: .leading, spacing: 2.0) {
                    Text("\(poem.poem ?? "")")
                        .font(.subheadline)
                        .fontWeight(Font.Weight.semibold)
                        .foregroundStyle(Color("TextColor"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
            .background(colorTheme.opacity(0.5))
            .cornerRadius(size10)
            .padding(.horizontal, size10)
            
            
            VStack(alignment: .leading) {
                ForEach(explanations.prefix(3), id:\.self) { explanation in
                    VStack(alignment: .leading, spacing: 2.0) {
                        if let title = explanation.title, title != "" {
                            Text("\(title): ")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundStyle(Color("TextColor"))
                                .padding(.bottom, 5)
                        }
                        Text("\(explanation.meaning ?? "")")
                            .font(.body)
                            .foregroundStyle(Color("TextColor"))
                        
//                        Divider().background(.gray)
//                            .padding(.vertical)
                    }
                    .padding(.top, size10)
                }
            }.padding()
        }
        .padding(.horizontal, size20)
        .padding(.vertical, size40)
        .background(colorTheme.opacity(0.35))
        .frame(width: UIScreen.main.bounds.width)
    }
    
    var body: some View {
        // Save as image icon
        Button(action: {
            let renderer = ImageRenderer(content: getPoemScreenshotView)
            if let image = renderer.uiImage {
                let imageSaver = ImageSever()
                imageSaver.writeToPhotoAlbum(image: image)
                
                completionCallBack!()
            }
        }) {
            HStack(spacing: 5) {
                Image(systemName: "camera")
                Text("நகல்")
            }
            .font(.subheadline)
            .foregroundStyle(iconTintColor)
        }
    }
}

//#Preview {
//    PoemScreenshotView()
//}
