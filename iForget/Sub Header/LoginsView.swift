//
//  LoginsView.swift
//  iForget
//
//  Created by Vinícius Lopes on 06/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI
import CoreData
import WebKit
import Combine

struct LoginsView: View {
    @ObservedObject var userSettings = UserSettings()
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Login.entity(), sortDescriptors:[
                    NSSortDescriptor(keyPath: \Login.loginSite, ascending: true)])
    var login: FetchedResults<Login>
    
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
                    ForEach(login, id: \.self) {login in
                        Logins( showCopy: self.$showCopy, login: login).environment(\.managedObjectContext, self.moc)
                    }
                }
            }
            .navigationBarTitle("Logins", displayMode: .inline)
        }
    }
}

struct LoginsView_Previews: PreviewProvider {
    static var previews: some View {
        LoginsView()
    }
}

struct Logins: View {
    
    @Binding var showCopy: Bool
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @State private var iconLink = ""
    @State private var showLink = false
    @State private var activeEdit = false
    @State private var activeLink = false
    
    @State var activeSwipeLeft = false
    @State var activeAnimation = false
    
    @State var shareText = ""
    @State var shareSheetShowing = false
    
    @ObservedObject var login: Login
    
    @State var goForward = false
    @State var goBack = false
    @State var reloadPage = false
    @State var webTitle = ""
    
    var body: some View {
        
        VStack(spacing: 0){
            VStack(spacing: 0){
                if self.showLink == false {
                    ZStack{
                        if self.shareSheetShowing{
                            ActivityViewController(text: self.$shareText, showing: $shareSheetShowing)
                                .frame(width: 0, height: 0)
                        }
                        HStack{
                            ZStack{
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
                                    
                                    Image(systemName: self.login.fav ? "star.fill" : "star")
                                        .foregroundColor(Color("Color5"))
                                        .padding(.trailing, 20)
                                        .onTapGesture {
                                            self.activeSwipeLeft = false
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35){
                                                self.login.fav.toggle()
                                                try? moc.save()
                                            }
                                        }
                                    
                                    Image(systemName: "trash")
                                        .foregroundColor(Color.red)
                                        .padding(.trailing, 30)
                                        .onTapGesture {
                                            self.deleteLogin()
                                            self.activeSwipeLeft = false
                                        }
                                }
                                .frame(height: 47)
                                .background(Color.gray.opacity(0.1))
                                
                                HStack{
                                    ZStack{
                                        HStack{
                                            ZStack{
                                                Image(systemName: "link")
                                                    .font(.system(size: 14.5, weight: .medium))
                                                    .foregroundColor(Color("Color4"))
                                                    .padding()
                                                    .frame(width: 25, height: 25)
                                                
                                                Image(iconLink)
                                                    .resizable()
                                                    .renderingMode(.original)
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 25, height: 25)
                                                    .cornerRadius(5)
                                            }
                                            
                                            Text(login.loginTitle ?? "")
                                                .font(.system(size: 15))
                                                .padding(.leading,7)
                                            
                                            Spacer()
                                            
                                            if self.login.fav == true {
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
                         
                    }
                    .fullScreenCover(isPresented: $activeEdit) {
                        NavigationView{
                            DetailLoginView(login: login)
                        }
                    }
                } else {
                    
                    VStack(spacing: 0){
                        ZStack{
                            HStack{
                                ZStack{
                                    Image(systemName: "link")
                                        .font(.system(size: 14.5, weight: .medium))
                                        .foregroundColor(Color("Color4"))
                                        .padding()
                                        .frame(width: 25, height: 25)
                                    
                                    Image(iconLink)
                                        .resizable()
                                        .renderingMode(.original)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 25)
                                        .cornerRadius(5)
                                }
                                
                                Text(login.loginTitle ?? "")
                                    .lineLimit(1)
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 15, weight: .medium))
                                    .padding(.leading,7)
                                
                                Spacer()
                                
                                if self.login.fav == true {
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
                            .fullScreenCover(isPresented: $activeEdit) {
                                NavigationView{
                                    DetailLoginView(login: login)
                                }
                            }
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack(spacing: 10){
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(Color("Color5"))
                                        .frame(height: 60)
                                        .cornerRadius(5)
                                    VStack(spacing: 0){
                                        HStack(){
                                            Text("Login")
                                                .foregroundColor(Color("Color7"))
                                                .minimumScaleFactor(1)
                                                .font(.system(size: 15, weight: .medium))
                                                .lineLimit(1)
                                                .padding(.horizontal, 40)
                                        }
                                    }
                                    .fixedSize()
                                }
                                .padding(.leading)
                                .onTapGesture {
                                    self.activeLink.toggle()
                                    
                                }
                                .fullScreenCover(isPresented: $activeLink) {
                                    NavigationView{
                                        VStack{
                                            HStack{
                                                HStack{
                                                    
                                                    Image(systemName: "xmark")
                                                        .foregroundColor(Color.white)
                                                        .onTapGesture{
                                                            self.activeLink.toggle()
                                                        }
                                                }
                                                
                                                Spacer(minLength: 0)
                                                
                                                HStack{
                                                    Spacer(minLength: 0)
                                                    
                                                    Image(systemName: "lock")
                                                        .foregroundColor(Color.white)
                                                        .opacity(self.webTitle != "" ? 1 : 0)
                                                    Text(webTitle)
                                                        .lineLimit(1)
                                                        .foregroundColor(Color.white)
                                                    
                                                    Spacer(minLength: 0)
                                                }
                                                .frame(maxWidth: 200)
                                                .padding(.horizontal)
                                                
                                                Spacer()
                                                
                                                HStack{
                                                    
                                                    Image(systemName: "arrow.clockwise")
                                                        .foregroundColor(Color.white)
                                                        .onTapGesture{
                                                            self.reloadPage.toggle()
                                                        }
                                                }
                                            }
                                            .frame(height: 47)
                                            .padding(.horizontal)
                                            .background(Color.black.opacity(0.5))
                                            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                                            .ignoresSafeArea(.all, edges: .top)
                                            
                                            Spacer(minLength: 0)
                                            
                                            WebView(goForward: $goForward, goBack: $goBack,reloadPage: $reloadPage, webTitle: $webTitle, url: "https://\(self.login.loginSite ?? "")")
                                            
                                            Spacer(minLength: 0)
                                            
                                            ZStack{
                                                Rectangle()
                                                    .frame(height: 47)
                                                    .foregroundColor(Color.black.opacity(0.5))
                                                HStack{
                                                    Image(systemName: "arrow.left")
                                                        .foregroundColor(Color.white)
                                                        .onTapGesture{
                                                            print("goBack")
                                                            self.goBack = true
                                                        }
                                                    
                                                    Image(systemName: "arrow.right")
                                                        .foregroundColor(Color.white)
                                                        .padding(.leading,40)
                                                        .onTapGesture{
                                                            print("goForward")
                                                            self.goForward = true
                                                        }
                                                    Spacer(minLength: 0)
                                                }
                                                .padding(.horizontal)
                                            }
                                            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                                            
                                        }
                                        .ignoresSafeArea(.all, edges: .bottom)
                                        .ignoresSafeArea(.all, edges: .top)
                                        .navigationBarHidden(true)
                                    }
                                }
                                
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(Color("Color8"))
                                        .opacity(0.13)
                                        .frame(height: 60)
                                        .cornerRadius(5)
                                    VStack(spacing: 0){
                                        Text("USERNAME")
                                            .font(.system(size: 10, weight: .medium))
                                            .opacity(0.6)
                                            .padding(.top)
                                            .padding(.bottom, 10)
                                            .padding(.horizontal, 40)
                                        HStack{
                                            Text("\(self.login.loginUsername ?? "")")
                                                .font(.system(size: 15, weight: .medium))
                                                .lineLimit(1)
                                                .padding(.horizontal, 40)
                                                .padding(.bottom)
                                        }
                                    }
                                    .fixedSize()
                                }
                                .onTapGesture {
                                    self.showCopy = true
                                    UIPasteboard.general.string = self.login.loginUsername
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        self.showCopy = false
                                    }
                                }
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(Color("Color8"))
                                        .opacity(0.13)
                                        .frame(minWidth: 100)
                                        .frame(height: 60)
                                        .cornerRadius(5)
                                    VStack(spacing: 0){
                                        Text("PASSWORD")
                                            .font(.system(size: 10, weight: .medium))
                                            .opacity(0.6)
                                            .padding(.top)
                                            .padding(.bottom, 10)
                                            .padding(.horizontal, 40)
                                        HStack{
                                            Text("\(self.login.loginPassword ?? "")")
                                                .font(.system(size: 15, weight: .medium))
                                                .lineLimit(1)
                                                .padding(.horizontal, 40)
                                                .padding(.bottom)
                                        }
                                    }
                                    .fixedSize()
                                    
                                }
                                .padding(.trailing)
                                .onTapGesture {
                                    self.showCopy = true
                                    UIPasteboard.general.string = self.login.loginPassword
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        self.showCopy = false
                                    }
                                }
                            }
                            .padding(.bottom)
                        }
                    }
                    .background(Color.white.opacity(0.01))
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
                        self.login.fav.toggle()
                        try? moc.save()
                    }){
                        HStack{
                            Text(self.login.fav ? "Remove from Favourites" : "Add to Favourites")
                            Image(systemName: "star")
                                .font(.system(size: 16))
                                .foregroundColor(Color("Color4"))
                                .padding()
                                .frame(width: 28, height: 28)
                        }
                    }
                    
                    Button(action: {
                        self.deleteLogin()
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
        .onAppear {
            self.iconLink = "\(self.login.loginTitle ?? "")"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                self.activeAnimation = true
            }
        }
    }
    
    func deleteLogin(){
        moc.delete(login)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            try? self.moc.save()
        }
    }
    
    func refreshShareText(){
        self.shareText = """
        Title: \(self.login.loginTitle ?? "")
        Site: https://\(self.login.loginSite ?? "")
        Username: \(self.login.loginUsername ?? "")
        Password: \(self.login.loginPassword ?? "")
        
        Sent by the iForget app
        """
    }
    
    func openShare() {
        self.refreshShareText()
        self.shareSheetShowing.toggle()
        
    }
}

struct NavLogo: View {
    
    @Binding var webTitle: String
    @Binding var activeLink: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            HStack{
                Button(action: {
                    self.activeLink.toggle()
                }){
                    Text("Done")
                        .font(.body)
                        .foregroundColor(Color("Color5"))
                }
                Spacer()
                Image(systemName: "lock")
                    .font(.body)
                Text(webTitle)
                    .lineLimit(1)
                    .font(.body)
                Spacer()
            }
        }
        .frame(width: 200)
        .background(Color.clear)
    }
}
