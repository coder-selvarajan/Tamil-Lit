//
//  NaaladiyarCategoryView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 24/03/24.
//

import SwiftUI

struct NaaladiyarCategoryView: View {
    @State var poems: [NaaladiyarPoem]?
    @State var categories: [NaaladiyarCategory]
    @State var selCategory: NaaladiyarCategory?
    @State var selSubCategory: NaaladiyarSubcategory?
    @State var selSection: NaaladiyarSection?
    
    func updateCategory(category: NaaladiyarCategory) {
        self.selCategory = category
        if let subCategory = category.subcategories.first {
            updateSubCategory(subCategory: subCategory)
        }
    }
    
    func updateSubCategory(subCategory: NaaladiyarSubcategory) {
        self.selSubCategory = subCategory
        if let section = selSubCategory?.sections.first {
            updateSection(section: section)
        }
    }
    
    func updateSection(section: NaaladiyarSection) {
        self.selSection = section
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text("பால்:")
                    .foregroundStyle(.gray)
                    .font(.caption)
                    .fontWeight(.bold)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(categories) { category in
                            Text("\(category.category)")
                                .padding(10)
                                .font(.subheadline)
                                .foregroundColor(selCategory?.category == category.category ? .white : .gray)
                                .background(selCategory?.category == category.category ? .blue : .gray.opacity(0.20))
                                .cornerRadius(10.0)
                                .onTapGesture {
                                    updateCategory(category: category)
                                }
                            
                        }
                    }
                }
            }
            .padding(.bottom, 10)
            Divider()
            
            VStack(alignment: .leading) {
                Text("இயல்:")
                    .foregroundStyle(.gray)
                    .font(.caption)
                    .fontWeight(.bold)
                WrapView(data: selCategory?.subcategories ?? [], content: { subCategory in
                    Button(action: {}) {
                        Text(subCategory.subcategory)
                            .padding(10)
                            .font(.subheadline)
                            .foregroundColor(selSubCategory?.subcategory == subCategory.subcategory ? .white : .gray)
                            .background(selSubCategory?.subcategory == subCategory.subcategory ? .blue : .gray.opacity(0.20))
                            .cornerRadius(10.0)
                            .onTapGesture {
                                updateSubCategory(subCategory: subCategory)
                            }
                    }
                })
            }
            .padding(.bottom, 10)
            Divider()
            
            
            VStack(alignment: .leading) {
                Text("அதிகாரம்:")
                    .foregroundStyle(.gray)
                    .font(.caption)
                    .fontWeight(.bold)
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(selSubCategory?.sections ?? [], id: \.self) { section in
                            
                                HStack {
                                    Text("\(section.section)")
                                        .padding(.vertical, 10)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                            
                            Divider()
                        }
                    }
                }
            }
            
        }
        .padding(20)
        .navigationBarTitle("நாலடியார்")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if selCategory == nil {
                if let firstCategory = categories.first {
                    updateCategory(category: firstCategory)
                }
            }
        }
    }
}

//#Preview {
//    NaaladiyarCategoryView(poems: <#[NaaladiyarPoem]#>, categories: <#[NaaladiyarCategory]#>)
//}
