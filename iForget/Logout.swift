//
//  Logout.swift
//  iForget
//
//  Created by Vinícius Lopes on 03/08/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct Logout: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .leading){
                Group{
                    Text("Logout")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.vertical)
                    Text("In order to increase your privacy and security you're iForget account is associated with your Apple account. If you need to logout you´re iForget account we recommend you access: Settings/Apple ID/Sign Out.")
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.leading)
                        .opacity(0.6)
                }
            }
            .padding()
        }
    }
}

struct Logout_Previews: PreviewProvider {
    static var previews: some View {
        Logout()
    }
}
