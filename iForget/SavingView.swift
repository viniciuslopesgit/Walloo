//
//  SavingView.swift
//  iForget
//
//  Created by Vinícius Lopes on 29/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct SavingViewGrid: View {
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @State private var didTap:Bool = false
    @State private var showZoom = false
    
    @State var items : [Any] = []
    @State var showShare = false
    
    @State var search = ""
    
    let save: Saving
    
    var body: some View {
        HStack{
            Image(data: self.save.thumb, placeholder: "")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .scaleEffect(2.5)
                .clipped()
                .frame(height: 140)
                .cornerRadius(6)
                .shadow(color: Color.gray, radius: 0.5)
        }
        .onTapGesture {
            self.showZoom = true
        }
        .frame(height: 140)
        .sheet(isPresented: self.$showZoom) {
            NavigationView{
                DetailDocument(showZoom: self.$showZoom, save: save)
            }
        }
    }
}

