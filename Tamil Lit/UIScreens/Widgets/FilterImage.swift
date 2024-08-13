//
//  FilterImage.swift
//  Tamil Lit
//
//  Created by Selvarajan on 13/08/24.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct FilterImage: View {
    var imageName: String
    
    
    func applySilvertoneAndBWFilter(to inputImage: UIImage) -> UIImage? {
        let context = CIContext()
        
        // Apply Noir (Black and White) filter
        let noirFilter = CIFilter.photoEffectNoir()
        let silvertoneFilter = CIFilter.photoEffectProcess()
        
        guard let ciImage = CIImage(image: inputImage) else { return nil }
        noirFilter.inputImage = ciImage
        
        guard let noirOutput = noirFilter.outputImage else { return nil }
        
        // Apply Silvertone filter after Noir
        silvertoneFilter.inputImage = noirOutput
        guard let silvertoneOutput = silvertoneFilter.outputImage else { return nil }
        
        guard let cgImage = context.createCGImage(silvertoneOutput, from: silvertoneOutput.extent) else { return nil }
        
        return UIImage(cgImage: cgImage)
    }
    
    var body: some View {
        if let originalImage = UIImage(named: imageName), let filteredImage = applySilvertoneAndBWFilter(to: originalImage) {
            Image(uiImage: filteredImage)
                .resizable()
                .saturation(0.0)
        } else {
            Image(imageName)
                .resizable()
                .saturation(0.0)
        }
    }
}
