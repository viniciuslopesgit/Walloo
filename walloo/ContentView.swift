//
//  ContentView.swift
//  iForget
//
//  Created by Vinícius Lopes on 22/06/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI
import CoreData
import LocalAuthentication
import KeychainSwift

extension Image {
    public init(data: Data?, placeholder: String) {
        guard let data = data,
            let uiImage = UIImage(data: data) else {
                self = Image("defaultProfile")
                return
        }
        self = Image(uiImage: uiImage)
    }
}

struct ContentView: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var userSettings = UserSettings()
    @ObservedObject var productsStore = ProductsStore()
    @ObservedObject var audioRecorder: AudioRecorder
    
    @State private var expanded: Bool = false
    @State private var isLogin = false
    @State private var activeRot: Bool = false
    
    @State var isUnlocked = false
    @State var password = ""
    @State var createPassword = ""
    @State var createPasswordAgain = ""
    @State var passwordUser = ""
    @State var showError = false
    @State var errorOldPass: String = "Those passwords didn't match. Try again."
    @State var slideGesture = CGSize.zero
    @State var slideOne = false
    @State var showOptions = false
    @State var showAdd = false
    
    @State var showNotesView = false
    @State var showPasswordsView = false
    @State var showLoginsView = false
    @State var showBanksView = false
    @State var showFilesView = false
    
    @State private var slideOnePrevious = false
    @State private var animationLoggin = false
    @State private var activeBuy = false
    
    @State var index = UserDefaults.standard.integer(forKey: "index")

    
    @State private var showPass = false
    @State var goSecondOnboard = false
    @State var showNews = true
    @State var showUpgradeClose = false
    @State var showUpgrade = false
    
    var body: some View {
        
        ZStack{
            if userSettings.isFirst == true {
               
                if self.goSecondOnboard == false {
                    OnboardingOne(showUpgradeClose: $showUpgradeClose, goSecondOnboard: $goSecondOnboard, showNews: $showNews, showUpgrade: $showUpgrade)
                } else {
                    ZStack {
                        Color.white
                            .edgesIgnoringSafeArea(.all)
                        VStack{
                            VStack(alignment: .center){
                                Text("Create a password")
                                    .foregroundColor(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)))
                                    .font(.system(size: 32, weight: .medium))
                            }
                            .padding(.top, 20)
                            
                            VStack(alignment: .leading) {
                                Section{
                                    Text("CREATE PASSWORD")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 10, weight: .medium))
                                        .opacity(0.6)
                                    HStack{
                                        if self.showPass == false {
                                            SecureField("Create Password", text: $createPassword)
                                                .foregroundColor(Color.black)
                                                .font(.system(size: 16 ))
                                        } else {
                                            TextField("Create Password", text: $createPassword)
                                                .foregroundColor(Color.black)
                                                .font(.system(size: 16))
                                        }
                                        Spacer()
                                        VStack{
                                            Image(systemName: self.showPass == false ? "eye.slash" : "eye")
                                        }
                                        .onTapGesture {
                                            self.showPass.toggle()
                                        }
                                    }
                                }
                                Divider()
                                Section{
                                    Text("CONFIRM")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 10, weight: .medium))
                                        .opacity(0.6)
                                    HStack{
                                        if self.showPass == false {
                                            SecureField("Confirm", text: $createPasswordAgain)
                                                .font(.system(size: 16))
                                        } else {
                                            TextField("Confirm", text: $createPasswordAgain)
                                                .font(.system(size: 16))
                                        }
                                    }
                                }
                                Divider()
                            }
                            .padding()
                            HStack {
                                Text(errorOldPass)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(errorOldPass == "Success." ? Color.green : Color.red)
                                    .opacity(showError ? 1 : 0)
                                    .animation(.spring())
                                Spacer()
                            }
                            .padding(.leading)
                            
                            ButtonCreatePass()
                                .onTapGesture {
                                    if self.createPassword.count >= 6 {
                                        if self.createPassword == self.createPasswordAgain  {
                                            self.passwordUser = self.createPasswordAgain
                                            
                                            self.errorOldPass = "Success."
                                            self.showError = true
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                                self.guardKey()
                                            }
                                        } else {
                                            self.errorOldPass = "Those passwords didn't match. Try again."
                                            self.showError = true
                                        }
                                    } else if self.createPassword.count < 6 {
                                        self.errorOldPass = "Use 6 or more characters in a mixture of letters, numbers and symbols."
                                        self.showError = true
                                    } else if self.createPassword.count >= 6 {
                                        if self.createPassword != self.createPasswordAgain {
                                            self.errorOldPass = "Those passwords didn't match. Try again."
                                            self.showError = true
                                        }
                                    }
                                    if self.createPasswordAgain.count >= 6 {
                                        if self.createPassword != self.createPasswordAgain {
                                            self.errorOldPass = "Those passwords didn't match. Try again."
                                            self.showError = true
                                        }
                                    }
                                }
                            
                            Spacer()
                        }
                    }
                }
            } else if userSettings.isFirst == false {
                VStack(spacing: 0){
                    
                    if self.isUnlocked == true {
                        ZStack{
                            if self.index == 0 {
                                Home(showNotesView: $showNotesView,showPasswordsView: $showPasswordsView, showLoginsView:$showLoginsView,showBanksView: $showBanksView, showFilesView:$showFilesView, audioRecorder: audioRecorder).environment(\.managedObjectContext, self.moc)
                                    .accentColor(Color("Color5"))
                            } else if self.index == 1 {
                                SearchTabView().environment(\.managedObjectContext, self.moc)
                                    .accentColor(Color("Color5"))
                            } else if self.index == 2 {
                                FavouritesView()
                                    .accentColor(Color("Color5"))
                            } else if self.index == 3 {
                                UserView().environment(\.managedObjectContext, self.moc)
                                    .accentColor(Color("Color5"))
                            }
                        }
                        NewCustomTab(showNotesView: $showNotesView,showPasswordsView: $showPasswordsView, showLoginsView:$showLoginsView,showBanksView: $showBanksView, showFilesView: $showFilesView, index: self.$index, showAdd: self.$showAdd, isUnlocked: self.$isUnlocked, password: self.$password, audioRecorder: audioRecorder)
                            .frame(height: 47)
                    } else {
                        ZStack{
                            Color("Color1")
                                .edgesIgnoringSafeArea(.all)
                            VStack{
                                    VStack(alignment: .center, spacing: 0){
                                        Spacer()
                                        HStack{
                                            Image("iForgetLogo")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 120)
                                        }
                                        .padding(.bottom, 40)
                                        Spacer()
                                    VStack(alignment: .leading){
                                        Section{
                                            Text("PASSWORD")
                                                .font(.system(size: 10, weight: .medium))
                                                .opacity(0.6)
                                            SecureField("Enter your password", text: $password)
                                                .font(.system(size: 16, weight: .medium))
                                                .foregroundColor(Color("Color4"))
                                        }
                                        Divider()
                                        ZStack {
                                            HStack{
                                                ZStack{
                                                    Text("Incorrect password. Try again.")
                                                        .font(.system(size: 14, weight: .medium))
                                                        .foregroundColor(Color.red)
                                                        .opacity(showError ? 1 : 0)
                                                    
                                                    Text("Success.")
                                                        .font(.system(size: 14, weight: .medium))
                                                        .foregroundColor(Color.green)
                                                        .opacity(animationLoggin ? 1 : 0)
                                                        .padding(.trailing, 135)
                                                }
                                                Spacer()
                                            }
                                        }
                                    }
                                    .opacity(activeRot ? 0 : 1)
                                    HStack{
                                        Spacer()
                                        Button(action:{
                                            let keychain = KeychainSwift()
                                            if keychain.get("my key") == self.password {
                                                self.showError = false
                                                self.animationLoggin = true
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                self.activeRot = true
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                                    
                                                    self.isUnlocked = true
                                                    self.animationLoggin = false
                                                    self.activeRot = false
                                                }
                                            } else {
                                                
                                                self.showError = true
                                            }
                                        }){
                                            Text("Sign In")
                                                .font(.system(size: 16, weight: .medium))
                                                .foregroundColor(.white)
                                                .padding()
                                                .frame(width: 270, height: 47)
                                                .background(Color("ColorButton"))
                                                .cornerRadius(6)
                                        }
                                        Spacer()
                                    }
                                    .opacity(self.activeRot ? 0 : 1)
                                    .padding(.top)
                                    HStack{
                                        Spacer()
                                        Button(action: {
                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                            self.authenticate()
                                        }){
                                            HStack{
                                                
                                                Text("Use face ID")
                                                    .font(.system(size: 16, weight: .medium))
                                                    .foregroundColor(Color(#colorLiteral(red: 0.1582739637, green: 0.1582739637, blue: 0.1582739637, alpha: 1)))
                                                
                                            }
                                            .frame(width: 270, height: 47)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 6).stroke(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)), lineWidth: 1)
                                                )
                                            .background(Color.white)
                                            .cornerRadius(6)
                                            .padding(.top)
                                        }
                                        .padding(.bottom)
                                        Spacer()
                                    }
                                    .opacity(self.userSettings.useTouch ? 1 : 0)
                                    .opacity(self.activeRot ? 0 : 1)
                                }.padding()
                            }
                        }
                        .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 1))
                        .onAppear(perform: self.userSettings.useTouch ? authenticate : nil)
                    }
                }
                .ignoresSafeArea(self.isUnlocked ? .all : .container, edges: .bottom)
            }
        }
        .sheet(isPresented: self.$showAdd) {
            SelectOptionsView(audioRecorder: self.audioRecorder, showAdd: self.$showAdd).environment(\.managedObjectContext, self.moc)
        }
        
        
        
    }
    func guardKey() {
        
        let keychain = KeychainSwift()
        //  keychain.delete("my key")
        keychain.set(self.passwordUser, forKey: "my key")
        isUnlocked = true
        self.userSettings.isFirst = false
        
        print("save")
        
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func simpleError() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success{
                        self.activeRot = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            
                            self.simpleSuccess()
                            self.isUnlocked = true
                            self.animationLoggin = false
                            self.activeRot = false
                        }
                    } else {
                        
                        self.simpleError()
                        
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified. Please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "Ok", style: .default))
                    }
                }
                
            }
        } else {
            let ac = UIAlertController(title: "Biometry unavailable", message: "You device is not configured for biomectric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
        }
    }
}

// DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView( productsStore: ProductsStore(), audioRecorder: AudioRecorder())
    }
}
//DEBUG


struct ButtonCreatePass : View {
    var body: some View {
        
        VStack {
            ZStack {
                VStack{
                    Text("Create Password")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.white)
                }
                .frame(width: 270, height: 47)
                .background(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)))
                .cornerRadius(6)
            }
            .padding()
        }
        
    }
}