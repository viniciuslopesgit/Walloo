//
//  Files.swift
//  iForget
//
//  Created by Vinícius Lopes on 08/09/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI
import CoreData
import StoreKit
import Combine

struct Files: View {
    @ObservedObject var audioRecorder: AudioRecorder
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showAdd = false
    
    var body: some View {
        ZStack{
            ZStack{
                ScrollView(.vertical, showsIndicators: false){
                    ListFiles()
                    Spacer()
                }
            }
            .navigationBarTitle("Files", displayMode: .inline)
        }
        .sheet(isPresented: self.$showAdd ){
            SelectOptionsView(audioRecorder: self.audioRecorder, showAdd: self.$showAdd).environment(\.managedObjectContext, self.moc)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Files_Previews: PreviewProvider {
    static var previews: some View {
        Files(audioRecorder: AudioRecorder())
    }
}

struct ListFiles : View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack{
                Text("FILES")
                    .font(.system(size: 13, weight: .medium))
                    .opacity(0.3)
                    .padding(.leading)
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                Spacer()
            }
            Divider()
            NavigationLink(destination: DocumentsView()){
                HStack{
                    Image(systemName: "photo")
                        .font(.system(size: 16))
                        .foregroundColor(Color("Color4"))
                        .padding()
                        .frame(width: 28, height: 28)
                    
                    Text("Photos")
                        .foregroundColor(Color("Color4"))
                        .font(.system(size: 15))
                    Spacer()
                }
                .frame(height: 47)
                .padding(.horizontal)
            }
            Divider()
                .padding(.leading)
            NavigationLink(destination: AudiosView(audioRecorder: AudioRecorder())){
                HStack{
                    Image(systemName: "mic")
                        .font(.system(size: 18))
                        .foregroundColor(Color("Color4"))
                        .padding()
                        .frame(width: 28, height: 28)
                    
                    Text("Recorded Audios")
                        .foregroundColor(Color("Color4"))
                        .font(.system(size: 15))
                    Spacer()
                    
                }
                .frame(height: 47)
                .padding(.horizontal)
            }
            Divider()
        }
        .padding(.top, 20)
    }
}
