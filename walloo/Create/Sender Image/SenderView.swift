//
//  SenderView.swift
//  iForget
//
//  Created by Vinícius Lopes on 22/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct SenderView: View {
    
    @Binding var show: Bool
    @Binding var activeSheet: ActiveSheet
    @Binding var sourceType: UIImagePickerController.SourceType
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State var image : Data = .init(count: 0)
    @State var imageThumb : Data = .init(count: 0)
    @State var name = ""
    @State var description = ""
    
    @State private var value: CGFloat = 0
    @State private var keyboardActive: Bool = false
    
    let randomInt = Int.random(in: 000001..<100000)
    let now = "\(Date().toString(dateFormat: "dd-MM-YY"))"
    
    var body: some View {
        NavigationView{
            ZStack{
                if self.image.count != 0 {
                    Text("")
                        .onAppear{
                            if self.image.count != 0 {
                                let newSaving = Saving(context: self.moc)
                                if self.description.count <= 0 {
                                    newSaving.descriptions = "IMG_\(self.randomInt)"
                                } else {
                                    newSaving.descriptions = self.description
                                }
                                
                                newSaving.username = "\(self.now)"
                                
                                newSaving.imageD = self.image
                                newSaving.thumb = self.imageThumb
                                newSaving.date = ("\(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss"))")
                                
                                try? self.moc.save()
                                
                                self.image = .init(count: 0)
                                self.imageThumb = .init(count: 0)
                            }
                    }
                    
                }
            }
        }
        .sheet(isPresented: self.$show, content: {
            ImagePicker(show: self.$show, image: self.$image, imageThumb: self.$imageThumb, sourceType: self.sourceType)
        })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                self.show = false
        }
    }
}
