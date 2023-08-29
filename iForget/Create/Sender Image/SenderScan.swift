//
//  SenderScan.swift
//  iForget
//
//  Created by Vinícius Lopes on 30/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct SenderScan: View {
    
    @Binding var showScan: Bool
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State var imageScan : Data = .init(count: 0)
    @State var imageScanThumb: Data = .init(count:0)
    @State var name: String = ""
    @State var description: String = ""
    
    let randomInt = Int.random(in: 0001..<1000)
    let now = "\(Date().toString(dateFormat: "dd-MM-YY"))"
    
    var body: some View {
        NavigationView{
            ZStack{
                if self.imageScan.count != 0 {
                    Text("")
                        .onAppear{
                            if self.imageScan.count != 0 {
                                let newSaving = Saving(context: self.moc)
                                if self.description.count <= 0 {
                                    newSaving.descriptions = "IMG_\(self.randomInt)"
                                } else {
                                    newSaving.descriptions = self.description
                                }
                                newSaving.username = "\(self.now)"
                                
                                newSaving.imageD = self.imageScan
                                newSaving.thumb = self.imageScanThumb
                                
                                try? self.moc.save()
                            } else {
                                return
                            }
                    }
                    
                }
            }
        }
        .sheet(isPresented: $showScan){
            ScanDocumentView(imageScan: self.$imageScan, imageScanThumb: self.$imageScanThumb)
        }
            
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.showScan = false
        }
    }
}
