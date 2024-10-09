//
//  NotesView.swift
//  iForget
//
//  Created by Vinícius Lopes on 03/08/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI
import CoreData

struct NotesView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Note.entity(), sortDescriptors:[
                    NSSortDescriptor(keyPath: \Note.dateCreateHours, ascending: false)])
    var note: FetchedResults<Note>
    
    var body: some View {
        ScrollView(.vertical){
            ZStack{
                LazyVStack(spacing: 0){
                    ForEach(note, id: \.self) {note in
                        Notes(note: note).environment(\.managedObjectContext, self.moc)
                    }
                }
            }
            .navigationBarTitle("Secure Notes", displayMode: .inline)
        }
    }
}

struct Notes: View {
    
    @ObservedObject var userSettings = UserSettings()
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @State private var finalDate = ""
    @State private var showText = false
    @State private var dontHaveTitle = true
    
    @State var activeSwipeLeft = false
    @State var activeAnimation = false
    
    @State var shareText = ""
    @State var shareSheetShowing = false
    
    @ObservedObject var note: Note
    
    var body: some View {
        VStack(spacing: 0){
                VStack(spacing: 0){
                    ZStack{
                        
                        if self.shareSheetShowing{
                            ActivityViewController(text: self.$shareText, showing: $shareSheetShowing)
                                .frame(width: 0, height: 0)
                        }
                        
                        HStack{
                            Spacer()
                            
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(Color("Color5"))
                                .padding(.trailing, 20)
                                .onTapGesture {
                                    self.refreshShareText()
                                    self.activeSwipeLeft = false
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35){
                                        self.shareSheetShowing.toggle()
                                    }
                                }
                            
                            Image(systemName: self.note.fav ? "star.fill" : "star")
                                .foregroundColor(Color("Color5"))
                                .padding(.trailing, 20)
                                .onTapGesture {
                                    self.activeSwipeLeft = false
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35){
                                        self.note.fav.toggle()
                                        try? moc.save()
                                    }
                                }
                            
                            Image(systemName: self.note.reminder ? "clock.fill" : "clock")
                                .foregroundColor(Color("Color5"))
                                .padding(.trailing, 20)
                                .onTapGesture {
                                    self.activeSwipeLeft = false
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35){
                                        self.note.reminder.toggle()
                                        try? moc.save()
                                    }
                                }
                            
                            Image(systemName: "trash")
                                .foregroundColor(Color.red)
                                .padding(.trailing, 30)
                                .onTapGesture {
                                    self.deleteNote()
                                    self.activeSwipeLeft = false
                                }
                        }
                        .frame(maxHeight: 200)
                        .background(Color.gray.opacity(0.1))
                       
                        VStack(alignment: .leading){
                            
                            if self.note.title != "" {
                                ZStack{
                                    VStack(alignment: .leading){
                                        HStack{
                                            Text(self.note.title ?? "")
                                                .font(.system(size: 17, weight: .medium))
                                                .padding(.top)
                                            
                                            Spacer()
                                            
                                            if self.note.reminder == true {
                                                Image(systemName: "clock")
                                                    .font(.system(size: 15))
                                                    .foregroundColor(Color("Color5"))
                                                    .padding(.top, 10)
                                            }
                                            
                                            if self.note.fav == true {
                                                Image(systemName: "star")
                                                    .font(.system(size: 15))
                                                    .foregroundColor(Color("Color5"))
                                                    .padding(.top, 10)
                                            }
                                        }
                                        .padding(.horizontal)
                                        .onAppear{
                                            self.dontHaveTitle = false
                                        }
                                        Text(self.note.note ?? "")
                                            .font(.system(size: 15))
                                            .padding(.horizontal)
                                            .padding(.top, 10)
                                        
                                        Text("\(self.finalDate)")
                                            .font(.system(size: 12))
                                            .opacity(0.5)
                                            .padding(.vertical)
                                            .padding(.leading)
                                    }
                                    swipeGesture(activeSwipeLeft: self.$activeSwipeLeft, activeAnimation: self.$activeAnimation)
                                }
                            } else {
                                ZStack{
                                    VStack(alignment: .leading){
                                        HStack{
                                            HStack{
                                                Text(self.note.note ?? "")
                                                    .lineLimit(1)
                                                    .font(.system(size: 17, weight: .medium))
                                                    .padding(.top)
                                                Spacer()
                                            }
                                            .frame(maxWidth: 100)
                                            
                                            Spacer()
                                            if self.note.reminder == true {
                                                    Image(systemName: "clock")
                                                        .font(.system(size: 15))
                                                        .foregroundColor(Color("Color5"))
                                                        .padding(.top, 10)
                                            }
                                            if self.note.fav == true {
                                                    Image(systemName: "star")
                                                        .font(.system(size: 15))
                                                        .foregroundColor(Color("Color5"))
                                                        .padding(.top, 10)
                                            }
                                        }
                                        .padding(.horizontal)
                                        VStack{
                                            Text("\(self.note.note ?? "")")
                                                .font(.system(size: 15))
                                            Spacer()
                                        }
                                        .padding(.top, self.dontHaveTitle ? 20 : 10)
                                        .padding(.horizontal)
                                        
                                        Text("\(self.finalDate)")
                                            .font(.system(size: 12))
                                            .opacity(0.5)
                                            .padding(.vertical)
                                            .padding(.leading)
                                    }
                                    
                                    swipeGesture(activeSwipeLeft: self.$activeSwipeLeft, activeAnimation: self.$activeAnimation)
                                }
                            }
                        }
                        .frame(maxHeight: 200)
                        .background(Color("Color7"))
                        .offset(x: self.activeSwipeLeft ? -210 : 0)
                        .animation(self.activeAnimation  ? .spring(response: 0.40, dampingFraction: 0.75, blendDuration: 0) : .none)
                    }
                }
                .contextMenu{
                    Button(action: {
                        self.showText.toggle()
                    }){
                        HStack{
                            Text("Edit")
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 16))
                                .foregroundColor(Color("Color4"))
                                .padding()
                                .frame(width: 28, height: 28)
                        }
                    }
                    
                    Button(action: {
                        self.refreshShareText()
                        self.shareSheetShowing.toggle()
                    }){
                        HStack{
                            Text("Share")
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 16))
                                .foregroundColor(Color("Color4"))
                                .padding()
                                .frame(width: 28, height: 28)
                        }
                    }
                    
                    Button(action: {
                        self.note.fav.toggle()
                        try? moc.save()
                    }){
                        HStack{
                            Text(self.note.fav ? "Remove from Favourites" : "Add to Favourites")
                            Image(systemName: "star")
                                .font(.system(size: 16))
                                .foregroundColor(Color("Color4"))
                                .padding()
                                .frame(width: 28, height: 28)
                        }
                    }
                    
                    Button(action: {
                        self.deleteNote()
                    }){
                        HStack{
                            Text("Move to Trash")
                            Image(systemName: "trash")
                                .font(.system(size: 16))
                                .foregroundColor(Color.red)
                                .padding()
                                .frame(width: 28, height: 28)
                        }
                    }
                }
            Divider()
                .padding(.leading)
        }
        .background(Color.white.opacity(0.01))
        .onTapGesture {
            if self.activeSwipeLeft != true {
                self.activeAnimation = false
                self.showText = true
            } else {
                self.activeSwipeLeft.toggle()
            }
        }
        .fullScreenCover(isPresented: self.$showText){
            DetailNote(note: self.note).environment(\.managedObjectContext, self.moc)
                .accentColor(Color("Color5"))
        }
        .onAppear{
            
            if self.note.dateCreate == "\(Date().toString(dateFormat: "dd-MM-YY"))" {
                self.finalDate = "Today"
            } else {
                self.finalDate = "\(self.note.dateCreate ?? "")"
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if self.userSettings.isAutoLock {
                self.showText = false
            }
        }
    }
    func deleteNote(){
        moc.delete(note)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            try? self.moc.save()
        }
    }
    
    func refreshShareText(){
        self.shareText = """
        \(self.note.title ?? "")
        \(self.note.note ?? "")
        
        Sent by the iForget app
        """
    }
}

