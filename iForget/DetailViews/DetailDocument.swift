//
//  DetailDocument.swift
//  iForget
//
//  Created by Vinícius Lopes on 23/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//
import CoreData
import SwiftUI

struct DetailDocument: View {
    
    @Binding var showZoom: Bool
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingDeleteAlert = false
    
    @State var scale: CGFloat = 1.0
    @State var showCopy: Bool = false
    @State var items : [Any] = []
    @State var shareSheet = false
    
    @State var destroy = false
    
    let save: Saving
    
    @State var image : Data = .init(count: 0)
    
    var body: some View {
        ZStack{
            VStack{
                GeometryReader { geo in
                    ScrollView(.vertical){
                    Image(data: self.save.imageD, placeholder: "")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(self.scale)
                    .gesture(MagnificationGesture()
                        .onChanged { value in
                            self.scale = value.magnitude
                        }
                        .onEnded { value in
                            self.scale = 1.0
                            }
                    )
                        .onTapGesture(count: 2) {
                            self.scale = self.scale * 2
                    }
                        .onTapGesture(count: 1) {
                                self.scale = 1
                        }
                    .animation(.spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0.3))
                }
                Spacer()
                }
            }
        }
        .background(Color.black)
        .sheet(isPresented: $shareSheet, content: {
            ShareSheet(items: self.items)
        })
            .onAppear{
                if self.destroy == true {
                    self.deleteDocument()
                } else {
                    return
                }
        }
        .navigationBarTitle("\(self.save.descriptions ?? "Unknown")", displayMode: .inline)
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete Document"), message: Text("Are you sure?"),
                  primaryButton: .destructive(Text("Delete")){
                    self.deleteDocument()
                }, secondaryButton: .cancel()
            )
        }
        .navigationBarItems(trailing:
            HStack{
                Button(action: {
                    self.showingDeleteAlert = true
                }) {
                    VStack{
                        Image(systemName:"trash")
                            .foregroundColor(Color("Color6"))
                    }.padding(.vertical)
                }
                .padding(.trailing, 20)
                
                Button(action: {
                    self.items.removeAll()
                    self.items.append(UIImage.init(data: self.save.imageD!)!)
                    
                    self.shareSheet.toggle()
                }) {
                    VStack{
                        Image(systemName:"square.and.arrow.up")
                            .foregroundColor(Color("Color6"))
                    }
                    .padding(.vertical)
                }
            }
        )
    }
    
    func deleteDocument(){
        moc.delete(save)
        presentationMode.wrappedValue.dismiss()
        self.showZoom = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            try? self.moc.save()
        }
    }
}


struct ShareSheet : UIViewControllerRepresentable {
    
    var items : [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}
