//
//  SaveAsImage.swift
//  Tamil Lit
//
//  Created by Selvarajan on 24/07/24.
//

import Foundation
import SwiftUI
import UIKit
import PhotosUI

class ImageSever: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Saved!")
    }
}


extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

func saveImageToPhotoLibrary(image: UIImage, completion: @escaping (Bool) -> Void) {
    PHPhotoLibrary.requestAuthorization { status in
        if status == .authorized {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            completion(true)
        } else {
            // Handle the case where the user denies access
            print("Photo library access denied")
            completion(false)
        }
    }
}
