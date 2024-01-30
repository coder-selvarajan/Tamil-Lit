//
//  WrapView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/01/24.
//

import SwiftUI

struct WrapView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    var data: Data
    var content: (Data.Element) -> Content
    
    @State private var totalHeight: CGFloat = 0
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        var lastElementSize = CGSize.zero

        return ZStack(alignment: .topLeading) {
            ForEach(Array(data.enumerated()), id: \.element) { index, element in
                self.content(element)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= lastElementSize.height
                        }
                        let result = width
                        if index == data.count - 1 {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        if index == data.count - 1 {
                            height = 0
                        } else {
                            lastElementSize = CGSize(width: d.width, height: d.height)
                        }
                        return result
                    })
            }
        }
        .background(viewHeightReader($totalHeight))
    }
    
    private func viewHeightReader(_ height: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                height.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
