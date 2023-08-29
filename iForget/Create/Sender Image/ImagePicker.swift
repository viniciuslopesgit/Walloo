//
//  ImagePicker.swift
//  iForget
//
//  Created by Vinícius Lopes on 21/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//
import SwiftUI
import Combine
import QuickLookThumbnailing

struct ImagePicker : UIViewControllerRepresentable {
    
    
    @Binding var show: Bool
    @Binding var image: Data
    @Binding var imageThumb: Data
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context:
        UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        
        return ImagePicker.Coordinator(child1: self)
        
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) ->
        UIImagePickerController {
            
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = context.coordinator
            return picker
    }
    
    class Coordinator : NSObject, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {
        
        var child : ImagePicker
        
        init(child1: ImagePicker) {
            
            child = child1
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.child.show = false
            
        }
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            
            let image = info[.originalImage]as! UIImage
            let data = image.rotate(radians: .pi * -2)?.jpegData(compressionQuality: 0.6)
            self.child.image = data!
            self.child.show = false
            self.child.imageThumb = image.thumbnail(radians: .pi * 2)?.jpegData(compressionQuality: 0.5)! as! Data
           
        }
    }
    
    
  /*  func downsample(imageAt imageURL: URL, to pointSize: CGSize, scale: CGFloat) -> UIImage {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions)!
        
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        let downsampleOptions =
            [kCGImageSourceCreateThumbnailFromImageAlways: true,
             kCGImageSourceShouldCacheImmediately: true,
             kCGImageSourceCreateThumbnailWithTransform: true,
             kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels] as CFDictionary
        
        let downsampleImage =
            CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions)!
        return UIImage(cgImage: downsampleImage)
    } */
    
}

extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension UIImage {
    func thumbnail(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/5, y: -self.size.height/5, width: self.size.width/2.5, height: self.size.height/2.5))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}


