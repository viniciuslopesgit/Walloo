//
//  subHeader.swift
//  iForget
//
//  Created by Vinícius Lopes on 14/08/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI
import CoreData

struct subHeader: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    @Binding var showNotesView: Bool
    @Binding var showPasswordsView: Bool
    @Binding var showLoginsView: Bool
    @Binding var showBanksView: Bool
    @Binding var showFilesView: Bool
    
    @FetchRequest(entity: Note.entity(), sortDescriptors:[
        NSSortDescriptor(keyPath: \Note.title, ascending: true)])
    var note: FetchedResults<Note>
    
    @FetchRequest(entity: Password.entity(), sortDescriptors:[
        NSSortDescriptor(keyPath: \Password.passwordTitle, ascending: true)])
    var password: FetchedResults<Password>
    
    @FetchRequest(entity: Login.entity(), sortDescriptors:[
        NSSortDescriptor(keyPath: \Login.loginTitle, ascending: true)])
    var login: FetchedResults<Login>
    
    @FetchRequest(entity: BankAccount.entity(), sortDescriptors:[
                    NSSortDescriptor(keyPath: \BankAccount.bankName, ascending: true)])
    var bankAccount: FetchedResults<BankAccount>
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    var body: some View{
        VStack(spacing: 0){
            if self.note.count != 0 || self.password.count != 0 || self.login.count != 0 || self.bankAccount.count != 0 {
            VStack(spacing: 0){
                HStack{
                    Text("VAULT")
                        .font(.system(size: 13, weight: .medium))
                        .opacity(0.3)
                        .padding(.leading)
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                    Spacer()
                }
                Divider()
            }
            VStack(spacing: 0){
                
                if self.note.count != 0 {
                    NavigationLink(destination: NotesView().environment(\.managedObjectContext, self.moc), isActive: $showNotesView){
                        VStack(spacing: 0){
                            HStack{
                                Image(systemName: "doc.text")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color("Color4"))
                                    .padding()
                                    .frame(width: 28, height: 28)
                                
                                Text("Secure Notes")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 15))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    .font(.system(size: 14))
                                    .opacity(0.3)
                            }
                            .padding()
                        }
                    }
                    .frame(height: 47)
                    .onTapGesture {
                        self.showNotesView.toggle()
                    }
                    Divider()
                        .padding(.leading)
                        .opacity(self.password.count != 0 || self.login.count != 0 || self.bankAccount.count != 0 ? 1 : 0)
                }
                
                if self.password.count != 0 {
                    NavigationLink(destination: PasswordsView().environment(\.managedObjectContext, self.moc), isActive: $showPasswordsView){
                        VStack(spacing: 0){
                            HStack{
                                Image(systemName: "lock")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color("Color4"))
                                    .padding()
                                    .frame(width: 28, height: 28)
                                
                                Text("Passwords")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 15))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    .font(.system(size: 14))
                                    .opacity(0.3)
                            }
                            .padding()
                        }
                    }
                    .frame(height: 47)
                    .onTapGesture {
                        self.showPasswordsView.toggle()
                    }
                    Divider()
                        .padding(.leading)
                        .opacity(self.login.count != 0 || self.bankAccount.count != 0 ? 1 : 0)
                }
                
                if self.login.count != 0 {
                    NavigationLink(destination: LoginsView().environment(\.managedObjectContext, self.moc), isActive: self.$showLoginsView){
                        VStack(spacing: 0){
                            HStack{
                                Image(systemName: "link")
                                    .font(.system(size: 14.5, weight: .medium))
                                    .foregroundColor(Color("Color4"))
                                    .padding()
                                    .frame(width: 28, height: 28)
                                
                                Text("Logins")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 15))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    .font(.system(size: 14))
                                    .opacity(0.3)
                            }
                            .padding()
                        }
                    }
                    .frame(height: 47)
                    .onTapGesture {
                        self.showLoginsView.toggle()
                    }
                    Divider()
                        .padding(.leading)
                        .opacity(self.bankAccount.count != 0 ? 1 : 0)
                }
                
                if self.bankAccount.count != 0 {
                    NavigationLink(destination: BankAccountView().environment(\.managedObjectContext, self.moc), isActive: self.$showBanksView){
                        VStack(spacing: 0){
                            HStack{
                                Image(systemName: "briefcase")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color("Color4"))
                                    .padding()
                                    .frame(width: 28, height: 28)
                                
                                Text("Bank Accounts")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 15))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    .font(.system(size: 14))
                                    .opacity(0.3)
                            }
                            .padding()
                        }
                    }
                    .frame(height: 47)
                    .onTapGesture {
                        self.showBanksView.toggle()
                    }
                }
                    
                    /*
                    Divider()
                        .padding(.leading)
                    
                     NavigationLink(destination: Files(audioRecorder: audioRecorder).environment(\.managedObjectContext, self.moc), isActive: self.$showFilesView){
                         VStack(spacing: 0){
                             HStack{
                                 Image(systemName: "folder")
                                     .font(.system(size: 16))
                                     .foregroundColor(Color("Color4"))
                                     .padding()
                                     .frame(width: 28, height: 28)
                                 
                                 Text("Files")
                                     .foregroundColor(Color("Color4"))
                                     .font(.system(size: 15))
                                 
                                 Spacer()
                                 
                                 Image(systemName: "chevron.right")
                                     .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                     .font(.system(size: 14))
                                     .opacity(0.3)
                             }
                             .padding()
                         }
                     }
                     .frame(height: 47)
                     .onTapGesture {
                         self.showBanksView.toggle()
                     }
                     */
            }
            }
                VStack(spacing: 0){
                    Divider()
                        .opacity(self.note.count != 0 || self.password.count != 0 || self.login.count != 0 || self.bankAccount.count != 0 ? 1 : 0)
                    HStack{
                        Text("CARDS")
                            .font(.system(size: 13, weight: .medium))
                            .opacity(0.3)
                            .padding(.leading)
                            .padding(.top, 5)
                            .padding(.bottom, 5)
                        Spacer()
                    }
                    .padding(.top, self.note.count != 0 || self.password.count != 0 || self.login.count != 0 || self.bankAccount.count != 0 ? 20 : 0)
                }
        }
    }
}
