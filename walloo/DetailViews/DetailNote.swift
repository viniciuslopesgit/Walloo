//
//  DetailNote.swift
//  iForget
//
//  Created by Vinícius Lopes on 03/08/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI
import CoreData
import UserNotifications

struct DetailNote: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingDeleteAlert = false
    @State private var showingDeleteText = false
    @State private var showingDeleteFile = false
    @State private var shareSheetShowing = false
    @State private var keyboardIsActive = false
    
    @State private var dateNotification = 0
    
    @State private var dateNotification1hour = Int(3600)
    @State private var dateNotificationTomorrow = Int(86400)
    @State private var dateNotificationNextWeek = Int(604800)
    
    let now = Date() // Current Date/Time
    
    @State private var textFav = ""
    @State private var textNoteShare = ""
    
    @State private var textOneHour = "In an Hour"
    
    @State var showCopy = false
    @State var editNote = ""
    @State var showEdit = false
    @State var changeText = ""
    @State var changeTitle = ""
    @State var title = ""
    @State var dateChange = ""
    @State var existeImage = 1
    @State var height: CGFloat = 0
    
    @State var showOptions = false
    @State var showOptionsReminder = false
    @State var showOptionsFav = false
    @State var textAlignment = 0
    
    let note : Note
    
    var body: some View {
        ZStack{
            NavigationView{
                ZStack{
                    VStack(spacing: 0){
                        TextField("", text: $title)
                            .modifier(PlaceholderStyle(showPlaceHolder: title.isEmpty, placeholder: "Title"))
                            .font(.system(size: 20, weight: .medium))
                            .padding(.top,30)
                            .padding(.bottom, 10)
                            .padding(.horizontal)
                        
                        TextEditor(text: self.$editNote)
                            .multilineTextAlignment(self.textAlignment == 1 ? .trailing : (self.textAlignment == 2 ? .center : .leading))
                            .padding(.leading)
                        
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
                    .onAppear {
                        self.refreshNote()
                        
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
                    .onDisappear {
                        self.saveEdit()
                    }
                    
                    if self.shareSheetShowing{
                        ActivityViewController(text: self.$textNoteShare, showing: $shareSheetShowing)
                            .frame(width: 0, height: 0)
                    }
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(
                    leading:
                        Button(action:{
                            self.presentationMode.wrappedValue.dismiss()
                        }){
                            Text("Save")
                                .font(.body)
                                .foregroundColor(Color("Color5"))
                        }
                        .padding(.vertical)
                    ,trailing:
                        HStack{
                            
                            if self.note.fav == true {
                                Image(systemName: "star")
                                    .font(.body)
                                    .foregroundColor(Color("Color5"))
                                    .padding(.trailing)
                            }
                            
                            if self.note.reminder == true {
                                Image(systemName: "clock")
                                    .font(.body)
                                    .foregroundColor(Color("Color5"))
                                    .padding(.trailing)
                            }
                            
                            /*
                            
                            Button(action: {
                                
                                if self.note.fav == false {
                                    self.textFav = "Add to Favourites"
                                } else {
                                    self.textFav = "Remove from Favourites"
                                }
                                
                                self.showOptions.toggle()
                                
                                
                            }){
                                if self.note.fav == true {
                                    Image(systemName: "star")
                                        .font(.body)
                                        .foregroundColor(Color("Color5"))
                                }
                            }
                            .padding(.vertical)
                            .padding(.trailing)
                            .actionSheet(isPresented: $showOptionsFav){
                                ActionSheet(title: Text(""), buttons: [
                                    .default(Text(textFav)) {
                                        self.shareSheetShowing.toggle()
                                    },
                                    .cancel()
                                ])
                            }
                            
                            Button(action: {
                                
                                self.showOptionsReminder.toggle()
                                
                            }){
                                if self.note.reminder == true {
                                    Image(systemName: "clock")
                                        .font(.body)
                                        .foregroundColor(Color("Color5"))
                                }
                            }
                            .padding(.vertical)
                            .padding(.trailing)
                            .actionSheet(isPresented: self.$showOptionsReminder) {
                                ActionSheet(title:  Text(""), buttons: [
                                    .default(Text(textOneHour)) {
                                        
                                        self.note.reminder = true
                                        try? self.moc.save()
                                        
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3660){
                                            self.note.reminder = false
                                            try? self.moc.save()
                                        }
                                        
                                        self.dateNotification = self.dateNotification1hour
                                        
                                        let content = UNMutableNotificationContent()
                                        
                                        content.title = self.note.title ?? ""
                                        content.body = self.note.note ?? ""
                                        content.sound = UNNotificationSound.default
                                        
                                        let open = UNNotificationAction(identifier: "open", title: "Open", options: .foreground)
                                        
                                        let cancel = UNNotificationAction(identifier: "cancel", title: "Cancel", options: .destructive)
                                        
                                        let categories = UNNotificationCategory(identifier: "action", actions: [open,cancel], intentIdentifiers: [])
                                        
                                        UNUserNotificationCenter.current().setNotificationCategories([categories])
                                        
                                        content.categoryIdentifier = "action"
                                        
                                        
                                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(self.dateNotification) , repeats: false)
                                        
                                        let req = UNNotificationRequest(identifier: "req", content: content, trigger: trigger)
                                        
                                        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
                                    },
                                    .default(Text("Tomorrow")) {
                                        
                                        self.note.reminder = true
                                        try? self.moc.save()
                                        
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 86460){
                                            self.note.reminder = false
                                            try? self.moc.save()
                                        }
                                        
                                        self.dateNotification = self.dateNotificationTomorrow
                                        
                                        let content = UNMutableNotificationContent()
                                        content.title = self.note.title ?? ""
                                        content.body = self.note.note ?? ""
                                        content.sound = UNNotificationSound.default
                                        
                                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(self.dateNotification) , repeats: false)
                                        
                                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                                        
                                        UNUserNotificationCenter.current().add(request)
                                    },
                                    .default(Text("Next Week")) {
                                        
                                        self.note.reminder = true
                                        try? self.moc.save()
                                        
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 604860){
                                            self.note.reminder = false
                                            try? self.moc.save()
                                        }
                                        
                                        self.dateNotification = self.dateNotificationNextWeek
                                        
                                        let content = UNMutableNotificationContent()
                                        content.title = self.note.title ?? ""
                                        content.body = self.note.note ?? ""
                                        content.sound = UNNotificationSound.default
                                        
                                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(self.dateNotification) , repeats: false)
                                        
                                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                                        
                                        UNUserNotificationCenter.current().add(request)
                                    },
                                    .cancel()
                                ])
                            }
                            
                            */
                            
                            //
                            
                            Button(action: {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                self.showOptions.toggle()
                                
                                if self.note.fav == false {
                                    self.textFav = "Add to Favourites"
                                } else {
                                    self.textFav = "Remove from Favourites"
                                }
                                
                            }){
                                Image(systemName: "ellipsis")
                                    .font(.system(size: 22, weight: .medium))
                                    .foregroundColor(Color("Color5"))
                            }
                            .padding(.vertical)
                            .padding(.trailing, 10)
                            .actionSheet(isPresented: $showOptions){
                                ActionSheet(title: Text(""), buttons: [
                                    .default(Text("Send Note")) {
                                        self.refreshNoteShare()
                                        self.shareSheetShowing.toggle()
                                    },
                                    .default(Text("Remind Me")) {
                                        self.showOptions = false
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                                            self.showOptionsReminder = true
                                        }
                                    },
                                    .default(Text(textFav)) {
                                        self.note.fav.toggle()
                                        try? self.moc.save()
                                    },
                                    .destructive(Text("Move to Trash")) {
                                        self.deleteNote()
                                    },
                                    .cancel()
                                ])
                            }
                        }
                )
            }
        }
        .modifier(DisableModalDismiss(disabled: true))
    }
    func tomorrow() -> Date {
        
        var dateComponents = DateComponents()
        dateComponents.setValue(1, for: .day); // +1 day
        
        let now = Date() // Current date
        let tomorrow = Calendar.current.date(byAdding: dateComponents, to: now)  // Add the DateComponents
        
        return tomorrow!
    }
    
    func refreshNote() {
        self.editNote = self.note.note ?? ""
        self.title = self.note.title ?? ""
        self.existeImage = Int(self.note.existImage)
        self.changeTitle = self.title
        self.changeText = self.note.note ?? ""
        self.dateChange = self.note.dateChange ?? ""
        self.textAlignment = Int(self.note.textAlignment)
    }
    
    func refreshNoteShare() {
        self.textNoteShare =
            """
        \(self.title)
        \(self.editNote)
        
        Sent by the iForget app
        """
    }
    func saveEdit() {
        
        if self.changeText != self.editNote {
            self.dateChange = "\(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss"))"
        } else {
            self.dateChange = self.note.dateCreateHours ?? ""
        }
        
        self.changeText = self.editNote
        self.changeTitle = self.title
        
        let editNote = self.note
        
        editNote.title = self.title
        editNote.note = self.editNote
        editNote.image = self.note.image
        editNote.imageThumb = self.note.imageThumb
        editNote.existImage = Int16(self.existeImage)
        editNote.dateChange = self.dateChange
        editNote.textAlignment = Int16(self.textAlignment)
        
        try? self.moc.save()
        
    }
    
    func deleteNote(){
        moc.delete(note)
        
        presentationMode.wrappedValue.dismiss()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            try? self.moc.save()
        }
    }
}

class UIActivityViewControllerHost: UIViewController {
    var message = ""
    var completionWithItemsHandler: UIActivityViewController.CompletionWithItemsHandler? = nil
    
    override func viewDidAppear(_ animated: Bool) {
        share()
    }
    
    func share() {
        // set up activity view controller
        let textToShare = [ message ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = completionWithItemsHandler
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
}

struct ActivityViewController: UIViewControllerRepresentable {
    @Binding var text: String
    @Binding var showing: Bool
    
    func makeUIViewController(context: Context) -> UIActivityViewControllerHost {
        // Create the host and setup the conditions for destroying it
        let result = UIActivityViewControllerHost()
        
        result.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
            // To indicate to the hosting view this should be "dismissed"
            self.showing = false
        }
        return result
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewControllerHost, context: Context) {
        // Update the text in the hosting controller
        uiViewController.message = text
    }
    
}
