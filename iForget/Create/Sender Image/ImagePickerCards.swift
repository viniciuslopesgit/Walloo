//
//  ImagePicker.swift
//  iForget
//
//  Created by Vinícius Lopes on 21/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//
import SwiftUI
import Combine

struct ImagePickerCards : UIViewControllerRepresentable {
    
    
    @Binding var show: Bool
    @Binding var image: Data
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context:
        UIViewControllerRepresentableContext<ImagePickerCards>) {
        
    }
    
    func makeCoordinator() -> ImagePickerCards.Coordinator {
        
        return ImagePickerCards.Coordinator(child1: self)
        
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerCards>) ->
        UIImagePickerController {
            
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = context.coordinator
            return picker
    }
    
    class Coordinator : NSObject, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {
        
        var child : ImagePickerCards
        
        init(child1: ImagePickerCards) {
            
            child = child1
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.child.show = false
            
        }
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            
            let image = info[.originalImage]as! UIImage
            let data = image.rotate(radians: .pi * -2)?.jpegData(compressionQuality: 0.1)
            self.child.image = data!
            self.child.show = false
           
        }
    }
    
    
}
