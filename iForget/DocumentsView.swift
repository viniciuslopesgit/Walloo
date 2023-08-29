//
//  DocumentsView.swift
//  iForget
//
//  Created by Vinícius Lopes on 14/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI
import CoreData
import Combine

enum ActiveSheet {
    case first, second, thirt
}

struct DocumentsView: View {
    @ObservedObject var userSettings = UserSettings()
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(entity: Saving.entity(), sortDescriptors: [
                    NSSortDescriptor(keyPath: \Saving.username, ascending: false),
                    NSSortDescriptor(keyPath: \Saving.descriptions, ascending: true)]
    ) var savings : FetchedResults<Saving>
    
    @State var search = ""
    @State var showOptions = false
    @State var show = false
    @State var showBuyPro = false
    @State var showScan = false
    
    @State var sourceType: UIImagePickerController.SourceType = .camera
    
    @State private var showGrid = false
    @State var activeSheet: ActiveSheet = .thirt
    
    var body: some View {
        VStack(spacing: 0){
            ZStack{
                SenderView(show: self.$show, activeSheet: self.$activeSheet, sourceType: self.$sourceType)
                    .frame(height: 0)
                SenderScan(showScan : self.$showScan)
                    .frame(height:0)
            }
            VStack(spacing: 0){
                if userSettings.workOffline == true {
                    VStack(alignment: .leading){
                        VStack{
                            HStack{
                                Text("Work offline")
                                    .font(.system(size: 17, weight: .medium))
                                Spacer()
                                Button(action: {
                                    self.userSettings.workOffline = false
                                }){
                                    Text("OK")
                                        .foregroundColor(Color("Color6"))
                                        .font(.system(size: 14, weight: .medium))
                                }
                            }
                            HStack{
                                Text("You can create, open and edit all files on this device while offline.")
                                    .font(.system(size: 14, weight: .medium))
                                    .opacity(0.4)
                            }
                            .padding(.top, 10)
                        }
                        .padding()
                    }
                    .background(Color(#colorLiteral(red: 0.9142013008, green: 0.9142013008, blue: 0.9142013008, alpha: 1)))
                    .cornerRadius(5)
                    .padding(.horizontal, 10)
                    .padding(.top)
                    .padding(.bottom)
                }
            }
            VStack(spacing: 0){
                FilesView(showGrid: self.$showGrid, showOptions: self.$showOptions)
            }
            
                
            /*
             if UserDefaults.standard.bool(forKey: "proBuy") == false {
             VStack{
             Spacer()
             AdView()
             .frame(height: 60, alignment: .center)
             }
             }
             */
        
    }.navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(
            trailing:
                HStack{
                    Button(action: {
                        if self.userSettings.proBuy == true {
                            self.showOptions.toggle()
                            
                        } else {
                            if self.savings.count <= 9999999 {
                                self.showOptions.toggle()
                            } else if self.savings.count >= 999999999 {
                                self.showBuyPro.toggle()
                            }
                        }
                    }){
                        VStack{
                            Image(systemName: "plus")
                                .font(.system(size: 26))
                                .foregroundColor(Color("Color5"))
                        }
                    }
                }
        )
        .actionSheet(isPresented: $showOptions){
            ActionSheet(title: Text("Create new"), buttons: [
                .default(Text("Photo from Camera Roll")) {
                    
                    self.sourceType = .photoLibrary
                    self.activeSheet = .first
                    self.show = true
                },
                .default(Text("Take Photo with Camera")) {
                    
                    self.sourceType = .camera
                    self.activeSheet = .first
                    self.show = true
                },
                .default(Text("Scan a Document").font(.system(size: 16, weight: .heavy))) {
                    
                    self.activeSheet = .second
                    self.showScan = true
                    // falta sheet do scan
                },
                .cancel()
            ])
            
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.showOptions = false
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
struct FilesView : View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(entity: Saving.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Saving.date, ascending: false)]
    ) var savings : FetchedResults<Saving>
    
    @Binding var showGrid: Bool
    @Binding var showOptions: Bool
    
    var body: some View {
        VStack{
            if savings.count > 0 {
                List{
                    ForEach(self.savings, id: \.self) { save in
                        ForEach(0..<100){ _ in
                            SavingViewGrid( save: save)
                        }
                    }
                    .onDelete(perform: self.deleteFiles)
                }
                .onAppear{
                    UITableView.appearance().backgroundColor = .systemBackground
                    UITableViewCell.appearance().backgroundColor = .systemBackground
                    UITableView.appearance().tableFooterView = UIView()
                    UITableView.appearance().separatorColor = .clear
                }
                .frame(height: UIScreen.main.bounds.height)
                .offset(y:1)
                
            } else if savings.count <= 0 {
                VStack{
                    Spacer()
                    HStack{
                        Text("No images found")
                            .font(.system(size: 27, weight: .medium))
                    }
                    HStack{
                        Text("Add a file by tapping the")
                        Image(systemName: "plus")
                    }
                    .opacity(0.6)
                    Spacer()
                }
            }
            Spacer()
        }
    }
    func deleteFiles(at offsets: IndexSet) {
        for offset in offsets {
            let file = savings[offset]
            moc.delete(file)
        }
        try? moc.save()
    }
}

