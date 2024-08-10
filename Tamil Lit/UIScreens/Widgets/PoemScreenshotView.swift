//
//  PoemScreenshotView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 25/07/24.
//

import PhotosUI
import SwiftUI

struct PoemScreenshotView: View {
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var themeManager: ThemeManager
    
    @Binding var poem: Poem
    @Binding var explanations: [Explanation]
    //    @State var iconTintColor: Color
    
    let colorTheme: Color
    //    let completionCallBack: (() -> Void)?
    let completionCallBack: ((Bool) -> Void)?
    
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
            return poemType + ": \(poem.number) \n" + title + ":"
        }
        
        return poemType + ": \(poem.number)"
    }
    
    var getPoemScreenshotView: some View {
        VStack(alignment: .leading, spacing: size10) {
            HStack(alignment: .top, spacing: 5) {
                if themeManager.selectedTheme == .primary {
                    Text("நூல்: ")
                        .padding(3)
                        .frame(width: size60)
                        .multilineTextAlignment(.trailing)
                        .background(.white)
                        .cornerRadius(5)
                        .padding(.trailing, 5)
                } else {
                    Text("நூல்: ")
                        .padding(3)
                        .foregroundStyle(themeManager.selectedTheme == .dark ? Color.white : Color.black)
                        .frame(width: size60)
                        .multilineTextAlignment(.trailing)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(5)
                        .padding(.trailing, 5)
                }
                
                Text("\(poem.bookname ?? "")")
                    .font(.body.bold())
                    .foregroundStyle(themeManager.selectedTheme == .dark ? Color.white : Color.black)
                
                Spacer()
            }
            .font(.subheadline)
            .padding(.top, size20)
            .padding(.leading, size20)
            .padding(.trailing, 5)
            .padding(.bottom, size10)
            
            if !getCategoryText().starts(with: "பாடல்") {
                HStack(alignment: .top, spacing: 5) {
                    if themeManager.selectedTheme == .primary {
                        Text("வகை: ")
                            .padding(3)
                            .frame(width: size60)
                            .multilineTextAlignment(.trailing)
                            .background(.white)
                            .cornerRadius(5)
                            .padding(.trailing, 5)
                    } else {
                        Text("வகை: ")
                            .padding(3)
                            .foregroundStyle(themeManager.selectedTheme == .dark ? Color.white : Color.black)
                            .frame(width: size60)
                            .multilineTextAlignment(.trailing)
                            .background(.gray.opacity(0.2))
                            .cornerRadius(5)
                            .padding(.trailing, 5)
                    }
                    Text("\(getCategoryText())")
                        .font(.body.bold())
                        .foregroundStyle(themeManager.selectedTheme == .dark ? Color.white : Color.black)
                    
                    Spacer()
                }
                .font(.subheadline)
                .padding(.leading, size20)
                .padding(.trailing, 5)
                .padding(.bottom, size15)
            }
            
            // Poem view
            VStack(alignment: .leading, spacing: size10) {
                Text("\(getPoemTitle())")
                    .font(.callout.bold())
                    .foregroundStyle(themeManager.selectedTheme == .dark ? Color.white : Color.black)
                
                VStack(alignment: .leading, spacing: 2.0) {
                    Text("\(poem.poem ?? "")")
                        .font(.body.bold())
                        .foregroundStyle(themeManager.selectedTheme == .dark ? Color.white : Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
            .padding(.vertical, size5)
            .frame(maxWidth: .infinity)
            .background(themeManager.selectedTheme == ThemeSelection.primary ? colorTheme.opacity(0.2) : .gray.opacity(0.2))
            .cornerRadius(size10)
            .padding(.horizontal, size10)
            
            VStack(alignment: .leading) {
                ForEach(explanations.prefix(3), id:\.self) { explanation in
                    VStack(alignment: .leading, spacing: 2.0) {
                        if let title = explanation.title, title != "" {
                            Text("\(title): ")
                                .font(.body.bold())
                                .foregroundStyle(themeManager.selectedTheme == .dark ? Color.white : Color.black)
                                .padding(.bottom, 5)
                        }
                        Text("\(explanation.meaning ?? "")")
                            .font(.body)
                            .foregroundStyle(themeManager.selectedTheme == .dark ? Color.white : Color.black)
                    }
                    .padding(.top, size10)
                }
            }.padding()
        }
        .padding(.horizontal, size20)
        .padding(.vertical, size40)
        .background(themeManager.selectedTheme == ThemeSelection.primary
                    ? colorTheme.opacity(0.2)
                    : themeManager.selectedTheme == .dark ? Color.black : Color.white)
        .frame(width: UIScreen.main.bounds.width)
        
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            // Save as image icon
            Button(action: {
                // Check photo library authorization status
                let status = PHPhotoLibrary.authorizationStatus()
                
                if status == .authorized || status == .limited {
                    // If permission is already granted, proceed with saving the image
                    saveImage()
                } else if status == .notDetermined {
                    // Request authorization
                    PHPhotoLibrary.requestAuthorization { newStatus in
                        if newStatus == .authorized || newStatus == .limited {
                            // Permission granted, save the image
                            saveImage()
                        } else {
                            DispatchQueue.main.async {
                                completionCallBack?(false)
                            }
                        }
                    }
                } else {
                    completionCallBack?(false)
                }
            }) {
                HStack(spacing: 5) {
                    Image(systemName: "camera")
                    Text("நகல்")
                }
                .font(.subheadline)
                .foregroundStyle(Color("TextColor"))
            }
        } else {
            EmptyView()
        }
    }
    
    func saveImage() {
        if #available(iOS 16.0, *) {
            DispatchQueue.main.async {
                let renderer = ImageRenderer(content: getPoemScreenshotView)
                if let image = renderer.uiImage {
                    let imageSaver = ImageSever()
                    imageSaver.writeToPhotoAlbum(image: image)
                    
                    // Call the completion callback with success
                    completionCallBack?(true)
                    
                } else {
                    // Call the completion callback with failure
                    completionCallBack?(false)
                }
            }
        }
    }
}
