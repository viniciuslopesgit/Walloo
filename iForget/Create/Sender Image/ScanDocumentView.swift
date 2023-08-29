//
//  ScanDocumentView.swift
//  iForget
//
//  Created by Vinícius Lopes on 14/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI
import VisionKit
import Combine

struct ScanDocumentView: UIViewControllerRepresentable {
    @Binding var imageScan: Data
    @Binding var imageScanThumb: Data
        
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
                // nothing to do here
    }
    
    
    func makeCoordinator() -> Coordinator {
        
       return Coordinator(child1: self)
    }
  
    func makeUIViewController(context: UIViewControllerRepresentableContext<ScanDocumentView>) -> VNDocumentCameraViewController {
        // to implement
        let documentViewController = VNDocumentCameraViewController()
        documentViewController.delegate = context.coordinator
        return documentViewController
    }
    
    
    
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
      
        var child : ScanDocumentView
        
        init(child1 : ScanDocumentView) {
            
            child = child1
            
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            // do the processing of the scan
            
            print("Found \(scan.pageCount)")
            
            if scan.pageCount > 0 {
                // ... your code here
                let originalImage = scan.imageOfPage(at: 0)
                let data = originalImage.jpegData(compressionQuality: 0.0)
                self.child.imageScan = data!
                self.child.imageScanThumb = originalImage.thumbnail(radians: .pi * 2)?.jpegData(compressionQuality: 0.0)! as! Data
            

            controller.dismiss(animated: true)
                
            } else {
                return
            }
        }
    }
}


extension UIImage {
    func bufferScan(radians: Float) -> UIImage? {
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


