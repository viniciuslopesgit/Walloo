//
//  SecurityView.swift
//  iForget
//
//  Created by Vinícius Lopes on 24/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct SecurityView: View {

    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                VStack(spacing: 0){
                    Divider()
                    HStack{
                        Toggle(isOn: $userSettings.useTouch) {
                            Text("Use Touch ID")
                            .font(.system(size: 15))
                        }
                    }
                    .padding(.horizontal)
                    .frame(height: 47)
                    Divider()
                        .padding(.leading)
                    
                    NavigationLink(destination: ChangePassword()){
                        HStack{
                            Text("Change Password")
                            .font(.system(size: 15))
                            .foregroundColor(Color("Color4"))
                            
                            Spacer()
                            Image(systemName: "chevron.right")
                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            .font(.system(size: 14))
                            .padding(.trailing)
                        }
                        .padding(.leading)
                        .frame(height: 47)
                    }
                    Divider()
                        .padding(.leading)
                    
                    Group{
                        NavigationLink(destination: AutoLockView()){
                        HStack{
                            Text("Auto-Lock")
                            .font(.system(size: 15))
                            .foregroundColor(Color("Color4"))
                            
                            Spacer()
                            Image(systemName: "chevron.right")
                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            .font(.system(size: 14))
                            .padding(.trailing)
                        }
                        .padding(.leading)
                        .frame(height: 47)
                        }
                        Divider()
                    }
                    
                    Spacer()
                }
            }
            .padding(.top, 35)
        }
        .navigationBarTitle("Security", displayMode: .inline)
    }
}

struct SecurityView_Previews: PreviewProvider {
    static var previews: some View {
        SecurityView()
    }
}
