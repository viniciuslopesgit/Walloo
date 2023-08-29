//
//  AudiosView.swift
//  iForget
//
//  Created by Vinícius Lopes on 08/09/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct AudiosView: View {
    @ObservedObject var audioRecorder: AudioRecorder
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        VStack {
            RecordingsList(audioRecorder: audioRecorder)
            RecordAudio(audioRecorder: audioRecorder)
        }
        .onAppear{
            UITableView.appearance().backgroundColor = .systemBackground
            UITableViewCell.appearance().backgroundColor = .systemBackground
            UITableView.appearance().tableFooterView = UIView()
            UITableView.appearance().separatorColor = .clear
        }
        .navigationBarTitle("Recorded Audios", displayMode: .inline)
        .navigationBarItems(
            trailing:
            EditButton()
                .font(.body)
                .foregroundColor(Color("Color5"))
                .padding(.vertical)
        )
        
    }
}

struct AudiosView_Previews: PreviewProvider {
    static var previews: some View {
        AudiosView(audioRecorder: AudioRecorder())
    }
}

struct RecordingsList: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        
        VStack{
            if audioRecorder.recordings.count > 0 {
                List {
                    ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                        RecordingRow(audioURL: recording.fileURL)
                    }
                    .onDelete(perform: delete)
                }
            } else if audioRecorder.recordings.count <= 0 {
                
                VStack{
                    Spacer()
                    HStack{
                        Text("No voice recordings found")
                            .font(.system(size: 27, weight: .medium))
                    }
                    HStack{
                        Text("Add a record by tapping the")
                        Image(systemName: "circle")
                    }
                    .opacity(0.6)
                    Spacer()
                }
            }
        }
        
    }
    
    func delete(at offsets: IndexSet) {
        
        var urlsToDelete = [URL]()
        for index in offsets {
            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
        }
        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)
    }
}

struct RecordingsList_Previews: PreviewProvider {
    static var previews: some View {
        RecordingsList(audioRecorder: AudioRecorder())
    }
}

struct RecordingRow: View {
    
    var audioURL: URL
    
    @ObservedObject var audioPlayer = AudioPlayer()
    
    var body: some View {
        HStack {
            Text("\(audioURL.lastPathComponent)")
            Spacer()
            if audioPlayer.isPlaying == false {
                Button(action: {
                    self.audioPlayer.startPlayback(audio: self.audioURL)
                }) {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                        .foregroundColor(Color("Color4"))
                }
            } else {
                Button(action: {
                    self.audioPlayer.stopPlayback()
                }) {
                    Image(systemName: "stop.fill")
                        .imageScale(.large)
                        .foregroundColor(Color("Color4"))
                }
            }
        }
    }
}

struct RecordAudio : View {
    @ObservedObject var audioRecorder: AudioRecorder
    @ObservedObject var userSettings = UserSettings()
    
    @Environment(\.presentationMode) var presentation
    
    let universalSize = UIScreen.main.bounds
    @State var isAnimated = false
    var body: some View {
        VStack{
            VStack{
                ZStack{
                    VStack{
                        ZStack {
                            getSinWave(interval: universalSize.width, amplitude: 130, baseline: 65 + universalSize.height/2)
                                .foregroundColor(Color.init("ColorWave2").opacity(0.4))
                                .foregroundColor(Color.green.opacity(0.1))
                                .offset(x: isAnimated ? -1*universalSize.width : 0)
                                .animation(
                                    Animation.linear(duration: 4)
                                        .repeatForever(autoreverses: false)
                            )
                            getSinWave(interval: universalSize.width, amplitude: 130, baseline: 65 + universalSize.height/2)
                                .foregroundColor(Color.init("ColorWave1").opacity(0.4))
                                .foregroundColor(Color.green.opacity(0.2))
                                .offset(x: isAnimated ? -1*universalSize.width : 0)
                                .animation(
                                    Animation.linear(duration: 2.5)
                                        .repeatForever(autoreverses: false)
                            )
                            
                            getSinWave(interval: universalSize.width*1.2, amplitude: 130, baseline: 70 + universalSize.height/2)
                                .foregroundColor(Color.init("ColorWave0").opacity(0.4))
                                .foregroundColor(Color.blue.opacity(0.2))
                                .offset(x: isAnimated ? -1*(universalSize.width*1.2) : 0)
                                .animation(
                                    Animation.linear(duration: 2)
                                        .repeatForever(autoreverses: false)
                            )
                            getSinWave(interval: universalSize.width*1.2, amplitude: 100, baseline: 95 + universalSize.height/2)
                                .foregroundColor(Color.black.opacity(0.2))
                                .offset(x: isAnimated ? -1*(universalSize.width*1.2) : 0)
                                .animation(
                                    Animation.linear(duration: 1.5)
                                        .repeatForever(autoreverses: false)
                            )
                        }
                        .opacity(audioRecorder.recording == true ? 1 : 0)
                        .frame(height:100)
                        .offset(y: -390)
                        .onAppear(){
                            self.isAnimated = true
                        }
                    }
                    
                    ZStack{
                        Button(action: {
                            
                            if self.audioRecorder.recording == false {
                                
                                print(self.audioRecorder.startRecording())
                                
                            } else {
                                
                                self.audioRecorder.stopRecording()
                            }
                            
                        }) {
                            ZStack{
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .clipped()
                                    .foregroundColor(Color("Color7"))
                                
                                
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipped()
                                    .foregroundColor(Color("Color4"))
                                
                                Image(systemName: audioRecorder.recording == false ?  "circle.fill" : "stop.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: audioRecorder.recording == false ? 50 : 22, height: audioRecorder.recording == false ? 50 : 22)
                                    .clipped()
                                    .foregroundColor(.red)
                            }
                            .padding()
                        }
                    }
                }
            }
            .padding(.bottom, userSettings.proBuy ? 20 : 50)
            .frame(width: UIScreen.main.bounds.width)
            .background(Color("Color4"))
            .cornerRadius(15, corners: [.topLeft, .topRight])
            .animation(.spring())
        }
        .navigationBarTitle("New Audio Record", displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                self.presentation.wrappedValue.dismiss()
            }){
                Text("Cancel")
                    .foregroundColor(Color("Color5"))
            }
        )
    }
    func getSinWave(interval:CGFloat, amplitude: CGFloat = 100 ,baseline:CGFloat = UIScreen.main.bounds.height/10) -> Path {
        Path{path in
            path.move(to: CGPoint(x: 0, y: baseline
            ))
            path.addCurve(
                to: CGPoint(x: 1*interval,y: baseline),
                control1: CGPoint(x: interval * (0.35),y: amplitude + baseline),
                control2: CGPoint(x: interval * (0.65),y: -amplitude + baseline)
            )
            path.addCurve(
                to: CGPoint(x: 2*interval,y: baseline),
                control1: CGPoint(x: interval * (1.35),y: amplitude + baseline),
                control2: CGPoint(x: interval * (1.65),y: -amplitude + baseline)
            )
            path.addLine(to: CGPoint(x: 2*interval, y: universalSize.height))
            path.addLine(to: CGPoint(x: 0, y: universalSize.height))
            
            
        }
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
