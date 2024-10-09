//
//  DetailPasswordView.swift
//  iForget
//
//  Created by Vinícius Lopes on 06/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//
import SwiftUI
import CoreData

struct DetailPasswordView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingDeleteAlert = false
    @State private var shareSheetShowing = false
    
    @State private var textFav = ""
    
    @State var activeEdit = false
    @State var showOptions = false
    
    @State var editTitle: String = ""
    @State var editPass: String = ""
    
    @State var shareText = ""
    
    let password: Password
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Section{
                        Text("TITLE")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            .padding(.top)
                        HStack{
                            TextField("", text: self.$editTitle)
                                .font(.system(size: 15))
                            Spacer()
                        }
                    }
                    Divider()
                        .opacity(0.5)
                    Section{
                        Text("PASSWORD")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                        HStack{
                            TextField("", text: self.$editPass)
                                .font(.system(size: 15))
                                .onAppear {
                                    self.editTitle = self.password.passwordTitle ?? ""
                                    self.editPass = self.password.passwordCode ?? ""
                                }
                            Spacer()
                        }
                    }
                    Divider()
                        .opacity(0.5)
                    
                }
                .background(Color("Color7"))
                .padding(.leading)
                Spacer()
            }
            if self.shareSheetShowing{
                ActivityViewController(text: self.$shareText, showing: $shareSheetShowing)
                    .frame(width: 0, height: 0)
            }
        }
        .onAppear{
            self.shareText = """
            Title: \(self.password.passwordTitle ?? "")
            Password: \(self.password.passwordTitle ?? "")
            
            Sent by the iForget app
            """
        }
        .navigationBarTitle("" , displayMode: .inline)
        .navigationBarItems(
            leading:
                Button(action: {
                    self.saveEdit()
                }){
                    Text("Save")
                        .font(.body)
                        .foregroundColor(Color("Color5"))
                }
            ,trailing:
                
                HStack{
                    if self.password.fav {
                        Image(systemName: "star")
                            .font(.body)
                            .foregroundColor(Color("Color5"))
                            .padding([.vertical, .trailing])
                    }
                    
                    Button(action: {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        self.showOptions.toggle()
                        
                        if self.password.fav == false {
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
                }
                
                .actionSheet(isPresented: self.$showOptions) {
                    ActionSheet(title: Text(""), buttons: [
                        .default(Text("Send Password")) {
                            self.shareSheetShowing.toggle()
                        },
                        .default(Text(textFav)) {
                            self.password.fav.toggle()
                            try? self.moc.save()
                            
                        },
                        .destructive(Text("Move to Trash")) {
                            self.deletePassword()
                        },
                        .cancel()
                    ])
                }
        )
    }
    
    func deletePassword(){
        moc.delete(password)
        
        try? self.moc.save()
        
        presentationMode.wrappedValue.dismiss()
    }
    func saveEdit() {
        
        let editPassword = self.password
        
        editPassword.passwordTitle = self.editTitle
        editPassword.passwordCode = self.editPass
        
        try? self.moc.save()
        
        self.presentationMode.wrappedValue.dismiss()
        
    }
}


struct DetailPasswordView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext( concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let password = Password(context: moc)
        password.passwordTitle = "Google"
        password.passwordCode = "1231232"
        
        return NavigationView{
            DetailPasswordView(password: password)
        }
        
    }
}
