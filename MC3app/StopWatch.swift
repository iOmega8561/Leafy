//
//  StopWatch.swift
//  MC3app
//
//  Created by Aryan Garg on 20/02/23.
//

import SwiftUI

struct StopWatch: View {
    
    @ObservedObject var stopWatchManager = StopWatchManager()
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Study Time")
                Text(String(format:"%.1f", stopWatchManager.secondsElapsed))
                    .font(.custom("Avenir", size: 60))
                    .frame(width: 200, height: 100, alignment: .leading)
                
                Text("Break")
                Text(String(format:"%.1f", stopWatchManager.studyBreak))
                    .font(.custom("Avenir", size: 60))
                    .frame(width: 200, height: 100, alignment: .leading)
                if stopWatchManager.mode == .stopped{
                    Button(action: {self.stopWatchManager.Start()}) {
                        TimerButton(label: "Start", buttonColor: .yellow, textColor: .black)
                    }
                }
                if stopWatchManager.mode == .running {
                    Button(action: {self.stopWatchManager.breakOn()}) {
                        TimerButton(label: "Break On", buttonColor: .yellow, textColor: .black)
                    }
                    Button(action: {self.stopWatchManager.stop()}) {
                        TimerButton(label: "Finish", buttonColor: .red, textColor: .white)
                    }
                }
                
                if stopWatchManager.mode == .breakOn {
                    
                    Button(action: {self.stopWatchManager.breakOff()}) {
                        TimerButton(label: "Break off", buttonColor: .yellow, textColor: .black)
                    }
                    Button(action: {self.stopWatchManager.stop()}) {
                        TimerButton(label: "Finish", buttonColor: .red, textColor: .white)
                    }
                }
                if stopWatchManager.mode == .breakOff {
                    
                    Button(action: {self.stopWatchManager.breakOn()}) {
                        TimerButton(label: "Break on", buttonColor: .yellow, textColor: .black)
                    }
                    Button(action: {self.stopWatchManager.stop()}) {
                        TimerButton(label: "Finish", buttonColor: .red, textColor: .white)
                    }
                }
            }
        }
    }
}

struct StopWatch_Previews: PreviewProvider {
    static var previews: some View {
        StopWatch()
    }
}

struct TimerButton:View{
    
    let label: String
    let buttonColor: Color
    let textColor: Color
    
    var body: some View{
        Text(label)
            .foregroundColor(textColor)
            .padding(.vertical, 20)
            .padding(.horizontal, 90)
            .background(buttonColor)
            .cornerRadius(10)
    }
}
