//
//  AutoLockView.swift
//  iForget
//
//  Created by Vinícius Lopes on 28/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct AutoLockView: View {
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                VStack(spacing: 0){
                    Divider()
                    HStack{
                        Toggle(isOn: $userSettings.isAutoLock) {
                            Text("Use Auto-Lock (Recommended)")
                                .font(.system(size: 15))
                        }
                    }
                    .padding(.horizontal)
                    .frame(height: 47)
                    Divider()
                    
                    Text("Auto-lock protects your data after a period of inactivity.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                        
                        .padding(.leading, 10)
                        .padding(.top)
                    Spacer()
                }
            }
            .padding(.top, 35)
        }
        .navigationBarTitle("Security", displayMode: .inline)
    }
}


struct AutoLockView_Previews: PreviewProvider {
    static var previews: some View {
        AutoLockView()
    }
}
