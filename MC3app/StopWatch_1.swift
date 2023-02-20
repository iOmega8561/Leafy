//
//  StopWatch_1.swift
//  MC3app
//
//  Created by Aryan Garg on 20/02/23.
//

import SwiftUI

struct StopWatch_1: View {
    
    @ObservedObject var stopWatchManager = StopWatchManager()
    
    var body: some View {
        VStack{
            Text(String(format:"%.1f", stopWatchManager.secondsElapsed))
                .font(.custom("Avenir", size: 60))
                .padding(.top,200)
                .padding(.bottom,100)
                .padding(.trailing,100)
                .padding(.leading,100)
            if stopWatchManager.mode == .stopped{
                Button(action: {self.stopWatchManager.Start()}) {
                    TimerButton(label: "Start", buttonColor: .yellow, textColor: .black)
                }
            }
            if stopWatchManager.mode == .running {
                Button(action: {self.stopWatchManager.pause()}) {
                    TimerButton(label: "Pause", buttonColor: .yellow, textColor: .black)
                }
                Button(action: {self.stopWatchManager.stop()}) {
                    TimerButton(label: "Stop", buttonColor: .red, textColor: .white)
                }
            }
            
            if stopWatchManager.mode == .paused {
                
                Button(action: {self.stopWatchManager.Start()}) {
                    TimerButton(label: "Start", buttonColor: .yellow, textColor: .black)
                }
                Button(action: {self.stopWatchManager.stop()}) {
                    TimerButton(label: "Stop", buttonColor: .red, textColor: .white)
                }
            }
            Spacer()
        }
    }
}

struct StopWatch_1_Previews: PreviewProvider {
    static var previews: some View {
        StopWatch_1()
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
