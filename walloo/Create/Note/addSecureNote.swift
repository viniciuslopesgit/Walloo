//
//  addSecureNote.swift
//  iForget
//
//  Created by Vinícius Lopes on 03/08/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI
import Combine

struct addSecureNote: View {
    @ObservedObject var userSettings = UserSettings()
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String = ""
    @State private var note: String = "Note"
    @State private var existImage = 0
    @State private var showBuyPro = false
    @State private var desativeAutoSave = false
    @State private var keyboardIsActive = false
    @State private var desativePlaceHolder = false
    
    @State var image: Data = .init(count: 0)
    @State var imageThumb: Data = .init(count: 0)
    @State var show = false
    @State var save = false
    @State var dateCreate = ""
    @State var textAlignment = 0
    
    @FetchRequest(entity: Note.entity(), sortDescriptors:[
                    NSSortDescriptor(keyPath: \Note.dateCreateHours, ascending: false)])
    var notes: FetchedResults<Note>
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                TextField("", text: $title)
                    .modifier(PlaceholderStyle(showPlaceHolder: title.isEmpty, placeholder: "Title"))
                    .font(.system(size: 20, weight: .medium))
                    .padding(.top,30)
                    .padding(.leading, 20)
                    .padding(.trailing)
            
                TextEditor(text: self.$note)
                    .multilineTextAlignment(self.textAlignment == 1 ? .trailing : (self.textAlignment == 2 ? .center : .leading))
                    .opacity(self.desativePlaceHolder ? 1 : 0.3)
                    .padding(.all)
                    .onTapGesture {
                        if self.desativePlaceHolder == false {
                            self.note = ""
                            self.desativePlaceHolder = true
                        }
                    }
                Spacer()
                ZStack{
                    HStack(spacing: 20){
                                Button(action: {
                                    self.textAlignment = 3
                                }){
                                    Image(systemName: "text.alignleft")
                                        .font(.system(size: 17))
                                        .foregroundColor(Color("Color4"))
                                        .opacity(0.4)
                                        .frame(width: 30, height: 43)
                                }
                                
                                Button(action: {
                                    self.textAlignment = 2
                                }){
                                    Image(systemName: "text.aligncenter")
                                        .font(.system(size: 17))
                                        .foregroundColor(Color("Color4"))
                                        .opacity(0.4)
                                        .frame(width: 30, height: 43)
                                }
                                
                                Button(action: {
                                    self.textAlignment = 1
                                }){
                                    Image(systemName: "text.alignright")
                                        .font(.system(size: 17))
                                        .foregroundColor(Color("Color4"))
                                        .opacity(0.4)
                                        .frame(width: 30, height: 43)
                                }
                        Spacer()
                        Image(systemName: "keyboard.chevron.compact.down")
                            .font(.system(size: 18))
                            .opacity(0.4)
                            .foregroundColor(Color("Color4"))
                            .padding(15)
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                
                            }
                        
                    }
                    .frame(height:43)
                    .padding(.leading, 10)
                    .background(Color("Color4").opacity(0.1))
                    .opacity(self.keyboardIsActive ? 1 : 0)
                    .background(Color.white.opacity(0.0001))
                }
                
            }
        }
        .onAppear{
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) {
                (not) in
                self.keyboardIsActive = true
            }
            NotificationCenter.default.addObserver(forName:
                                                    UIResponder.keyboardWillHideNotification, object: nil, queue: .main) {
                (_) in
                
                self.keyboardIsActive = false
            }
        }
        .sheet(isPresented: self.$showBuyPro){
            PurchaseView()
        }
        .onDisappear {
            if self.note != "Note" && self.note.count > 1 && self.desativeAutoSave == false {
                if self.userSettings.proBuy == true {
                    self.saveAll()
                    
                } else {
                    if self.notes.count <= 30 {
                        self.saveAll()
                    }
                }
            }
            
        }
        .modifier(DisableModalDismiss(disabled: true))
        .navigationBarTitle("New Secure Note", displayMode: .inline)
        .navigationBarItems(
            trailing:
                HStack{
                    Button(action: {
                        
                        self.desativeAutoSave = true
                        
                        if self.userSettings.proBuy == true {
                            self.saveAll()
                            
                        } else {
                            if self.notes.count <= 29 {
                                self.saveAll()
                            } else if self.notes.count >= 30 {
                                self.showBuyPro.toggle()
                            }
                        }
                    }){
                        Text("Save")
                            .font(.body)
                            .foregroundColor(Color("Color5"))
                    }
                }
        )
    }
    func existImagefunc() {
        self.existImage = 1
    }
    func saveAll() {
        let newNote = Note(context: self.moc)
        
        if self.image.count != 0 {
            newNote.title = self.title
            newNote.note = self.note
            newNote.image = self.image
            newNote.imageThumb = self.imageThumb
            newNote.existImage = Int16(self.existImage)
        } else {
            newNote.title = self.title
            newNote.note = self.note
            newNote.dateCreate = "\(Date().toString(dateFormat: "dd-MM-YY"))"
            newNote.dateCreateHours = "\(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss"))"
            newNote.textAlignment = Int16(self.textAlignment)
        }
        try? self.moc.save()
        
        self.presentationMode.wrappedValue.dismiss()
    }
}

public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .foregroundColor(Color("Color4")).opacity(0.5)
            }
            content
                .foregroundColor(Color("Color4"))
        }
    }
}

