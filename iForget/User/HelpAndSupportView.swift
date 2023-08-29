//
//  HelpAndSupportView.swift
//  iForget
//
//  Created by Vinícius Lopes on 24/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct HelpAndSupportView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Text("What's included in iForget Free?")
                        .font(.system(size: 14, weight: .medium))
                    VStack(alignment: .leading){
                        Text("""
                                           
                                           Access on all supported devices
                                           One-to-one password sharing
                                           An encrypted Vault to store and manage your site passwords, secure notes, and form fill items
                                           Save and fill site passwords
                                           Storage with secure notes
                                           Easy web form filling
                                           Secure password generator
                                           Extra security with Multifactor Authentication
                                           Password auditing using the Security Challenge

                                           """)
                            .font(.system(size: 16, weight: .medium))
                            .opacity(0.4)
                    }
                }
                .padding(.leading)
                .padding(.top)
                VStack(alignment: .leading){
                    Text("Will I lose any data if I switch to iForget Free?")
                        .font(.system(size: 14, weight: .medium))
                        Text("No. You will not lose any of your stored data, however, you will no longer be able to use iForget Premium features – including one-to-many sharing, Authentication options, priority technical support, and more.")
                            .font(.system(size: 16, weight: .medium))
                            .opacity(0.4)
                            .padding(.top)                }
                    .padding(.leading)
                VStack(alignment: .leading){
                    Text("How do I convert my existing account to a iForget Free account?")
                        .font(.system(size: 14, weight: .medium))
                    VStack{
                        Text("If you cancel your iForget Premium subscription or allow your iForget Premium to expire, your account will automatically convert to a iForget Free account.")
                            .font(.system(size: 16, weight: .medium))
                            .opacity(0.4)
                            .padding(.top)
                    }
                }
                .padding()
                VStack(alignment: .leading){
                    Text("I upgraded from iForget Free to iForget Premium and the app is not updating the version")
                        .font(.system(size: 14, weight: .medium))
                    VStack(alignment: .leading){
                        Text("Sometimes there may be some delay in confirming payment.")
                            .font(.system(size: 16, weight: .medium))
                            .opacity(0.4)
                            .padding(.top)
                        Text("We recommend run Restore Purchases, and reboot your iForget aplication.")
                        .font(.system(size: 16, weight: .medium))
                        .opacity(0.4)
                    }
                }
                .padding(.leading)
                VStack(alignment: .leading){
                    Text("For more information:")
                        .font(.system(size: 14, weight: .medium))
                    VStack(alignment: .leading){
                        Text("vinyl.contact.inc@gmail.com")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color.blue)
                            .padding(.top)
                    }
                }
                .padding(.leading)
                
                Spacer()
            }
            .padding(.bottom, 35)
        }
        .navigationBarTitle("How can we help you?")
    }
}

struct HelpAndSupportView_Previews: PreviewProvider {
    static var previews: some View {
        HelpAndSupportView()
    }
}
