//
//  NotificationsView.swift
//  iForget
//
//  Created by Vinícius Lopes on 25/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI
import CoreData

struct NotificationsView: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        ZStack{
            VStack{
                List{
                    Text("Welcome to iForget! Keep your documents and passwords save in on place")
                }
            }
            .navigationBarTitle("Notifications", displayMode: .inline)
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
