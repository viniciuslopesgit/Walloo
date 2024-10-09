//
//  SearchTabView.swift
//  iForget
//
//  Created by Vinícius Lopes on 28/09/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI
import CoreData

struct SearchTabView: View {
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @State var search = ""
    @State var recentSearch = ""
    
    var body: some View {
        NavigationView{
            VStack{
                SearchBar(text: $search)
                    .onChange(of: search) { recent in
                        self.saveRecentSearch()
                    }
                    .padding(.horizontal)
                    Divider()
                        .padding(.leading)
                
                Spacer(minLength: 0)
                
                ScrollView(.vertical){
                    if self.search.count != 0 {
                        VStack(spacing: 0){
                            HStack{
                                Text("NOTES")
                                    .font(.system(size: 13, weight: .medium))
                                    .opacity(0.3)
                                    .padding(.top, 5)
                                    .padding(.bottom, 5)
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                        .padding(.top)
                        NotesSearch(search: $search)
                        VStack(spacing: 0){
                            HStack{
                                Text("PASSWORDS")
                                    .font(.system(size: 13, weight: .medium))
                                    .opacity(0.3)
                                    .padding(.top, 5)
                                    .padding(.bottom, 5)
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                        .padding(.top)
                        PasswordsSearch(search: $search)
                        VStack(spacing: 0){
                            HStack{
                                Text("LOGINS")
                                    .font(.system(size: 13, weight: .medium))
                                    .opacity(0.3)
                                    .padding(.top, 5)
                                    .padding(.bottom, 5)
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                        .padding(.top)
                        LoginsSearch(search: $search)
                        VStack(spacing: 0){
                            HStack{
                                Text("BANK ACCOUNTS")
                                    .font(.system(size: 13, weight: .medium))
                                    .opacity(0.3)
                                    .padding(.top, 5)
                                    .padding(.bottom, 5)
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                        .padding(.top)
                        BankAccountsSearch(search: $search)
                    } else {
                        VStack(spacing: 0){
                            HStack{
                                Text("Recent Search")
                                    .font(.system(size: 16, weight: .medium))
                                Spacer(minLength: 0)
                            }
                            HStack{
                                Image(systemName: "magnifyingglass")
                                    .opacity(0.5)
                                Text(recentSearch)
                                    .font(.system(size: 16))
                                    .padding(.vertical)
                                Spacer(minLength: 0)
                            }
                            .padding(.top, 5)
                            .background(Color.white.opacity(0.0001))
                            
                            .onTapGesture {
                                self.search = self.recentSearch
                            }
                            
                            Divider()
                                .padding(.leading)
                            
                           /* Image("iForget_dog")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 150) */
                        }
                        .padding(.leading)
                        .padding(.top)
                    }
                }
                .onAppear{
                    self.recentSearch = UserDefaults.standard.string(forKey: "recentSearch") ?? ""
                }
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
    func saveRecentSearch() {
        if self.search.count != 0 {
            self.recentSearch = self.search
            
            UserDefaults.standard.setValue(self.recentSearch, forKey: "recentSearch")
        }
    }
}


struct NotesSearch: View {
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Note.entity(), sortDescriptors:[
        NSSortDescriptor(keyPath: \Note.title, ascending: true)])
    var note: FetchedResults<Note>
    
    @Binding var search: String

    var body: some View {
        
        LazyVStack(spacing: 0){
            ForEach(self.note.filter({self.self.search.isEmpty ? true : $0.title!.localizedCaseInsensitiveContains(self.search)}), id: \.self) { note in
                Notes(note: note).environment(\.managedObjectContext, self.moc)
            }
        }
        
    }
}

struct PasswordsSearch: View {
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Password.entity(), sortDescriptors:[
        NSSortDescriptor(keyPath: \Password.passwordTitle, ascending: true)])
    var password: FetchedResults<Password>
    
    @Binding var search: String
    @State var showCopy = false

    var body: some View {
        
        LazyVStack(spacing: 0){
            ForEach(self.password.filter({self.self.search.isEmpty ? true : $0.passwordTitle!.localizedCaseInsensitiveContains(self.search)}), id: \.self) { password in
                Passwords(showCopy: $showCopy, password: password).environment(\.managedObjectContext, self.moc)
            }
        }
        
    }
}

struct LoginsSearch: View {
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Login.entity(), sortDescriptors:[
        NSSortDescriptor(keyPath: \Login.loginSite, ascending: true)])
    var login: FetchedResults<Login>
    
    @Binding var search: String
    @State var showCopy = false

    var body: some View {
        
        LazyVStack(spacing: 0){
            ForEach(self.login.filter({self.self.search.isEmpty ? true : $0.loginTitle!.localizedCaseInsensitiveContains(self.search)}), id: \.self) { login in
                Logins(showCopy: $showCopy, login: login).environment(\.managedObjectContext, self.moc)
            }
        }
        
    }
}

struct BankAccountsSearch: View {
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: BankAccount.entity(), sortDescriptors:[
        NSSortDescriptor(keyPath: \BankAccount.bankName, ascending: true)])
    var bankAccount: FetchedResults<BankAccount>
    
    @Binding var search: String
    @State var showCopy = false

    var body: some View {
        
        LazyVStack(spacing: 0){
            ForEach(self.bankAccount.filter({self.self.search.isEmpty ? true : $0.bankName!.localizedCaseInsensitiveContains(self.search)}), id: \.self) { bankAccount in
                BankAccounts(showCopy: $showCopy, bankAccount: bankAccount).environment(\.managedObjectContext, self.moc)
            }
        }
        
    }
}
