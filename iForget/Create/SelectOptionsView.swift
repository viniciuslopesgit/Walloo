//
//  SelectOptionsView.swift
//  iForget
//
//  Created by Vinícius Lopes on 23/06/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct SelectOptionsView: View {
    @ObservedObject var audioRecorder: AudioRecorder
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @State private var showingAddScreen = false
    @State private var didTap:Bool = false
    @State private var showUpgrade = false
    
    @Binding var showAdd: Bool
    
    var body: some View {
        
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 0){
                    Section{
                        NavigationLink(destination: addSecureNote()) {
                            HStack{
                                Image(systemName: "doc.text")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color("Color4"))
                                    .padding()
                                    .frame(width: 28, height: 28)
                                
                                Text("Secure Note")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 15))
                                    .padding(.leading, 7)
                                Spacer()
                            }
                            .padding()
                            .frame(height: 47)
                        }
                        NavigationLink(destination: addPasswordView()) {
                            HStack{
                                Image(systemName: "lock")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color("Color4"))
                                    .padding()
                                    .frame(width: 28, height: 28)
                                
                                Text("Password")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 15))
                                    .padding(.leading, 7)
                                Spacer()
                            }
                            .padding()
                            .frame(height: 47)
                        }
                        NavigationLink(destination: addLoginView()) {
                            HStack{
                                Image(systemName: "link")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color("Color4"))
                                    .padding()
                                    .frame(width: 28, height: 28)
                                
                                Text("Login")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 15))
                                    .padding(.leading, 7)
                                Spacer()
                            }
                            .padding()
                            .frame(height: 47)
                        }
                        NavigationLink(destination: addBankAccountView()) {
                            HStack{
                                Image(systemName: "briefcase")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color("Color4"))
                                    .padding()
                                    .frame(width: 28, height: 28)
                                
                                Text("Bank Account")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 15))
                                    .padding(.leading, 7)
                                Spacer()
                            }
                            .padding()
                            .frame(height: 47)
                        }
                        NavigationLink(destination: addCardView()) {
                            HStack{
                                Image(systemName: "creditcard")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color("Color4"))
                                    .padding()
                                    .frame(width: 28, height: 28)
                                
                                
                                Text("Credit Card / Debit Card")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 15))
                                    .padding(.leading, 7)
                                Spacer()
                            }
                            .padding()
                            .frame(height: 47)
                        }
                    }
                    Section{
                        NavigationLink(destination: addCardIDView()) {
                            HStack{
                                Image(systemName: "person")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color("Color4"))
                                    .padding()
                                    .frame(width: 28, height: 28)
                                
                                Text("National ID")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 15))
                                    .padding(.leading, 7)
                                Spacer()
                            }
                            .padding()
                            .frame(height: 47)
                        }
                        NavigationLink(destination: addInsuranceCardView()) {
                            HStack{
                                Image(systemName: "plus")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("Color4"))
                                    .padding()
                                    .frame(width: 28, height: 28)
                                
                                Text("Insurance Card")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 15))
                                    .padding(.leading, 7)
                                Spacer()
                            }
                            .padding()
                            .frame(height: 47)
                        }
                        NavigationLink(destination: addDriversLicense()) {
                            HStack{
                                Image(systemName: "car")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color("Color4"))
                                    .padding()
                                    .frame(width: 28, height: 28)
                                
                                Text("Driver's License")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 15))
                                    .padding(.leading, 7)
                                Spacer()
                            }
                            .padding()
                            .frame(height: 47)
                        }
                        NavigationLink(destination: addCardPassport()) {
                            HStack{
                                Image(systemName: "person")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color("Color4"))
                                    .padding()
                                    .frame(width: 28, height: 28)
                                
                                Text("Passport")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 15))
                                    .padding(.leading, 7)
                                Spacer()
                            }
                            .padding()
                            .frame(height: 47)
                        }
                        /*
                         NavigationLink(destination: DocumentsView()) {
                            HStack{
                                Image(systemName: "photo")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color("Color4"))
                                    .padding()
                                    .frame(width: 28, height: 28)
                                
                                Text("Upload Photos")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 15))
                                    .padding(.leading, 7)
                                Spacer()
                            }
                            .padding()
                            .frame(height: 47)
                        }
                        .accentColor(Color("Color5"))
                        NavigationLink(destination: AudiosView(audioRecorder: audioRecorder)) {
                            HStack{
                                Image(systemName: "mic")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color("Color4"))
                                    .padding()
                                    .frame(width: 28, height: 28)
                                
                                Text("Record Audio")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 15))
                                    .padding(.leading, 7)
                                Spacer()
                            }
                            .padding()
                            .frame(height: 47)
                        }
                        .accentColor(Color("Color5"))
                        
                         NavigationLink(destination: addCardPassport()) {
                         HStack{
                         Image(systemName: "star.fill")
                         .font(.system(size: 14))
                         .foregroundColor(Color.white)
                         .padding()
                         .background(Color(#colorLiteral(red: 0.02352941176, green: 0.1921568627, blue: 0.7450980392, alpha: 1)))
                         .frame(width: 25, height: 25)
                         .cornerRadius(5)
                         
                         Text("Membership Card")
                         .foregroundColor(Color(#colorLiteral(red: 0.07753013959, green: 0.07753013959, blue: 0.07753013959, alpha: 1)))
                         .font(.system(size: 14, weight: .medium))
                         .padding(.leading, 7)
                         Spacer()
                         }
                         .padding()
                         .frame(height: 47)
                         }
                         .background(didTap ? Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) : Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                         .onTapGesture {
                         self.didTap = true
                         }
                         */
                    }
                }
                .padding(.bottom)
            }
            .sheet(isPresented: self.$showUpgrade){
                PurchaseView()
            }
            .navigationBarTitle("Create", displayMode: .inline)
            .navigationBarItems(leading:
                                    Button(action: {
                                        self.showAdd.toggle()
                                    }){
                                        Text("Cancel")
                                            .font(.body)
                                            .foregroundColor(Color("Color5"))
                                    }
            )
        }
        .accentColor(Color("Color5"))
        .modifier(DisableModalDismiss(disabled: true))
        .navigationViewStyle(StackNavigationViewStyle())
    }
}



extension UIApplication {
    
    func visibleViewController() -> UIViewController? {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return nil }
        guard let rootViewController = window.rootViewController else { return nil }
        return UIApplication.getVisibleViewControllerFrom(vc: rootViewController)
    }
    
    private static func getVisibleViewControllerFrom(vc:UIViewController) -> UIViewController {
        if let navigationController = vc as? UINavigationController,
           let visibleController = navigationController.visibleViewController  {
            return UIApplication.getVisibleViewControllerFrom( vc: visibleController )
        } else if let tabBarController = vc as? UITabBarController,
                  let selectedTabController = tabBarController.selectedViewController {
            return UIApplication.getVisibleViewControllerFrom(vc: selectedTabController )
        } else {
            if let presentedViewController = vc.presentedViewController {
                return UIApplication.getVisibleViewControllerFrom(vc: presentedViewController)
            } else {
                return vc
            }
        }
    }
}

struct DisableModalDismiss: ViewModifier {
    let disabled: Bool
    func body(content: Content) -> some View {
        disableModalDismiss()
        return AnyView(content)
    }
    
    func disableModalDismiss() {
        guard let visibleController = UIApplication.shared.visibleViewController() else { return }
        visibleController.isModalInPresentation = disabled
    }
}
