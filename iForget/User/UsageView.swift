//
//  UsaveView.swift
//  iForget
//
//  Created by Vinícius Lopes on 07/08/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct UsageView: View {
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Saving.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Saving.username, ascending: false),
        NSSortDescriptor(keyPath: \Saving.descriptions, ascending: true)]
    ) var savings : FetchedResults<Saving>
    
    @FetchRequest(entity: Note.entity(), sortDescriptors:[
        NSSortDescriptor(keyPath: \Note.title, ascending: true)])
    var note: FetchedResults<Note>
    
    @State var percentage: CGFloat = 0
    @State var showBuy = false
    @State private var isPro = UserDefaults.standard.bool(forKey: "proBuy")
    
    var body: some View {
        VStack{
            Spacer()
            ZStack{
                ZStack{
                    // Pulsation()
                    
                    Track()
                    Outline(percentage: percentage)
                    HStack{  Label(percentage: percentage); Text("%") }.font(.system(size: 34, weight: .heavy))
                }
            }
            Spacer()

                VStack{
                    
                    HStack{
                        Spacer()
                        if UserDefaults.standard.bool(forKey: "proBuy") == true{
                        Text("Using \(Double(CGFloat(self.savings.count) * 0.03030),specifier: "%.2f")% of 5GB of storage")
                            .font(.system(size: 14, weight: .medium))
                            .opacity(0.4)
                        } else {
                            Text("Upgrade for more space")
                            .font(.system(size: 14, weight: .medium))
                            .opacity(0.4)
                        }
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        
                        if self.isPro == false {
                            ZStack{
                                Rectangle()
                                    .foregroundColor(Color.white)
                                    .frame(width: 272, height: 47)
                                    .cornerRadius(5)
                                    .shadow(radius: 1)
                                Text("Get more space")
                                    .foregroundColor(Color(#colorLiteral(red: 0.02352941176, green: 0.1921568627, blue: 0.7450980392, alpha: 1)))
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 16, weight: .heavy))
                            }
                            .onTapGesture {
                                self.showBuy = true
                            }
                        }
                        Spacer()
                    }
                }
                .padding(.bottom)
                .navigationBarTitle("Storage", displayMode: .inline)
                .sheet(isPresented: self.$showBuy ){
                    PurchaseView()
            }
        }.padding()
            .onAppear {
                // self.percentage = CGFloat(self.savings.count) * 0.2 //max 500
                if UserDefaults.standard.bool(forKey: "proBuy") == true {
                    self.percentage = CGFloat(self.savings.count) * 0.03030
                } else {
                    if self.savings.count > 1 {
                    self.percentage = 99
                    }
                }
        }
    }
}

struct Label: View {
    var percentage: CGFloat = 0
    var body: some View {
        ZStack{
            Text(String(format: "%.0f", percentage))
                .foregroundColor(Color.black)
                .font(.system(size: 34))
                .fontWeight(.heavy)
        }
    }
}

struct Outline: View {
    var percentage: CGFloat = 0
    var colors: [Color] = [Color.outLineColor]
    
    var body: some View {
        ZStack{
            Circle()
                .fill(Color.clear)
                .frame(width: 250, height:  250)
            .overlay(
            Circle()
                .trim(from: 0, to: percentage * 0.01)
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .fill(AngularGradient(gradient: .init(colors: colors), center: .center, startAngle: .zero, endAngle: .init(degrees: 360)))
            ).animation(.spring(response: 2.0, dampingFraction: 1.0, blendDuration: 1.0))
        }
    }
}

struct Track: View {
    var colors: [Color] = [Color.trackColor]
    
    var body: some View {
        ZStack{
            Circle()
                .fill(Color.white)
                .frame(width: 250, height: 250)
            .overlay(
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 20))
                .fill(AngularGradient(gradient: .init(colors: colors), center: .center))
            )
        }
    }
}

/*
 struct Pulsation: View {
     @State private var pulsate = false
     var colors: [Color] = [Color.pulsatingColor]
     
     var body: some View {
         ZStack{
             Circle()
                 .fill(Color.pulsatingColor)
                 .frame(width: 245, height: 245)
                 .scaleEffect(pulsate ? 1.3 : 1.1)
                 .animation(Animation.easeOut(duration: 1.1).repeatForever(autoreverses: true))
                 .onAppear {
                     self.pulsate.toggle()
             }
         }
     }
 }
 */

struct UsaveView_Previews: PreviewProvider {
    static var previews: some View {
        UsageView()
    }
}

extension Color {
    static func rgb(r: Double, g: Double, b: Double) -> Color {
        return Color(red: r / 255, green: g / 255, blue: b / 255)
    }
    static let outLineColor = Color(#colorLiteral(red: 0.02352941176, green: 0.1921568627, blue: 0.7450980392, alpha: 1))
    static let trackColor = Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(0.7)
}
