//
//  PasswordsView.swift
//  iForget
//
//  Created by Vinícius Lopes on 06/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI
import CoreData

struct PasswordsView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Password.entity(), sortDescriptors:[
                    NSSortDescriptor(keyPath: \Password.passwordTitle, ascending: true)])
    var password: FetchedResults<Password>
    
    @State var showCopy: Bool = false
    
    var body: some View {
        
        ScrollView(.vertical){
            ZStack{
                VStack{
                    Spacer()
                    HStack{
                        Text("Copied ***** to clipboard")
                            .foregroundColor(Color(#colorLiteral(red: 0.07753013959, green: 0.07753013959, blue: 0.07753013959, alpha: 1)))
                            .font(.system(size: 14, weight: .medium))
                            .padding()
                    }
                    .background(Color(#colorLiteral(red: 0.9142013008, green: 0.9142013008, blue: 0.9142013008, alpha: 1)))
                    .opacity(1.0)
                    .frame(height: 47)
                    .cornerRadius(5)
                }
                .padding(.bottom)
                .zIndex(1)
                .opacity(showCopy ? 1.0 : 0.0)
                .animation(.spring())
                
                LazyVStack(spacing: 0){
                    ForEach(password, id: \.self) {password in
                        Passwords( showCopy: self.$showCopy, password: password)
                            .listRowInsets(EdgeInsets())
                    }
                }
            }
            .navigationBarTitle("Passwords", displayMode: .inline)
        }
    }
}

struct PasswordsView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordsView()
    }
}

struct Passwords: View {
    
    @Binding var showCopy: Bool
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @State private var showLink = false
    @State private var activeEdit = false
    
    @State var activeSwipeLeft = false
    @State var activeAnimation = false
    
    @State var shareText = ""
    @State var shareSheetShowing = false
    
    @ObservedObject var password: Password
    
    var body: some View {
        VStack(spacing: 0){
            VStack(spacing: 0){
                if self.showLink == false {
                    HStack{
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
                                
                                Image(systemName: self.password.fav ? "star.fill" : "star")
                                    .foregroundColor(Color("Color5"))
                                    .padding(.trailing, 20)
                                    .onTapGesture {
                                        self.activeSwipeLeft = false
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35){
                                            self.password.fav.toggle()
                                            try? moc.save()
                                        }
                                    }
                                
                                Image(systemName: "trash")
                                    .foregroundColor(Color.red)
                                    .padding(.trailing, 30)
                                    .onTapGesture {
                                        self.deletePassword()
                                        self.activeSwipeLeft = false
                                    }
                            }
                            .frame(height: 47)
                            .background(Color.gray.opacity(0.1))
                            
                            HStack{
                                ZStack{
                                    HStack{
                                        Image(systemName: "lock")
                                            .font(.system(size: 18))
                                            .foregroundColor(Color("Color4"))
                                            .padding()
                                            .frame(width: 28, height: 28)
                                        
                                        Text(password.passwordTitle ?? "")
                                            .foregroundColor(Color("Color4"))
                                            .font(.system(size: 15))
                                            .padding(.leading,7)
                                        
                                        Spacer()
                                        
                                        if self.password.fav == true {
                                            Image(systemName: "star")
                                                .font(.system(size: 15))
                                                .foregroundColor(Color("Color5"))
                                        }
                                    }
                                    .padding(.horizontal)
                                    swipeGesture(activeSwipeLeft: self.$activeSwipeLeft, activeAnimation: self.$activeAnimation)
                                }
                            }
                            .frame(height: 47)
                            .background(Color("Color7"))
                            .offset(x: self.activeSwipeLeft ? -170 : 0)
                            .animation(self.activeAnimation  ? .spring(response: 0.40, dampingFraction: 0.75, blendDuration: 0) : .none)
                            
                        }
                    }
                    .background(Color("Color7"))
                    .frame(height: 47)
                    .onTapGesture {
                        if self.activeSwipeLeft != true {
                            self.activeAnimation = false
                            self.showLink = true
                        } else {
                            self.activeSwipeLeft.toggle()
                        }
                    }
                } else {
                    VStack(spacing: 0){
                        HStack{
                            Image(systemName: "lock")
                                .font(.system(size: 18))
                                .foregroundColor(Color("Color4"))
                                .padding()
                                .frame(width: 25, height: 25)
                            
                            Text(password.passwordTitle ?? "")
                                .lineLimit(1)
                                .foregroundColor(Color("Color4"))
                                .font(.system(size: 15, weight: .medium))
                                .padding(.leading,7)
                            
                            Spacer()
                            
                            if self.password.fav == true {
                                Image(systemName: "star")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color("Color5"))
                            }
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .font(.system(size: 14))
                                .opacity(0.3)
                        }
                        .frame(height: 47)
                        .background(Color.white.opacity(0.0001))
                        .padding(.horizontal)
                        .onTapGesture {
                            self.activeEdit.toggle()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10){
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(Color("Color8"))
                                        .opacity(0.13)
                                        .frame(minWidth: 100)
                                        .frame(height: 60)
                                        .cornerRadius(5)
                                    VStack(spacing: 0){
                                        Text("PASSWORD")
                                            .font(.system(size: 10))
                                            .opacity(0.6)
                                            .padding(.top)
                                            .padding(.bottom, 10)
                                            .padding(.horizontal, 40)
                                        HStack{
                                            Text("\(self.password.passwordCode ?? "")")
                                                .font(.system(size: 15))
                                                .lineLimit(1)
                                                .padding(.horizontal, 40)
                                                .padding(.bottom)
                                        }
                                    }
                                    .fixedSize()
                                }
                                .padding(.leading)
                                .onTapGesture {
                                    self.showCopy = true
                                    UIPasteboard.general.string = self.password.passwordCode
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        self.showCopy = false
                                    }
                                }
                            }
                            .padding(.bottom)
                        }
                    }
                    .background(Color.white.opacity(0.001))
                }
            }
            .contextMenu{
                Button(action: {
                    self.activeEdit.toggle()
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
                    self.password.fav.toggle()
                    try? moc.save()
                }){
                    HStack{
                        Text(self.password.fav ? "Remove from Favourites" : "Add to Favourites")
                        Image(systemName: "star")
                            .font(.system(size: 16))
                            .foregroundColor(Color("Color4"))
                            .padding()
                            .frame(width: 28, height: 28)
                    }
                }
                
                Button(action: {
                    self.deletePassword()
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
        .fullScreenCover(isPresented: $activeEdit){
            NavigationView{
                DetailPasswordView(password: password)
            }
        }
    }
    func deletePassword(){
        moc.delete(password)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            try? self.moc.save()
        }
    }
    
    func refreshShareText() {
        self.shareText = """
        \(self.password.passwordTitle ?? "")
        \(self.password.passwordCode ?? "")
        
        Sent by the iForget app
        """
    }
}
