//
//  SyncView.swift
//  iForget
//
//  Created by Vinícius Lopes on 28/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct SyncView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                VStack(spacing: 0){
                    Divider()
                    HStack{
                        Toggle(isOn: $userSettings.isSync) {
                            Text("Use iCloud Sync")
                                .font(.system(size: 15))
                        }
                    }
                    .padding(.horizontal)
                    .frame(height: 47)
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("iForget secures your information by encrypting it when it's in transit, storing it in iCloud in an encrypted format, and using secure tokens for authentication. For certain sensitive information, iForget uses end-to-end encryption. This means that only you can access your information, and only on devices where you’re signed into iCloud. No one else, not even Apple or iForget, can access end-to-end encrypted information.")
                            
                            .padding()
                            .font(.system(size: 14, weight: .medium))
                            .multilineTextAlignment(.leading)
                            .opacity(0.6)
                    }
                    
                    Spacer()
                }
            }
            .padding(.top, 35)
        }
        .navigationBarTitle("Security", displayMode: .inline)
    }
}
struct SyncView_Previews: PreviewProvider {
    static var previews: some View {
        SyncView()
    }
}
