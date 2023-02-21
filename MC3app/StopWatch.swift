//
//  StopWatch.swift
//  MC3app
//
//  Created by Aryan Garg on 21/02/23.
//

import SwiftUI

struct StopWatch: View {
    @ObservedObject var stopWatchManager = StopWatchManager()
    @State var showModal: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("Study Time")
                        .font(.system(size: 30))
                    
                    if stopWatchManager.mode == .running {
                        
                        Button(action: {self.stopWatchManager.breakOn()}) {
                            TimerButton(label: "Break", buttonColor: .yellow, textColor: .black)
                        }
                    }
                    if stopWatchManager.mode == .breakOff {
                        
                        Button(action: {self.stopWatchManager.breakOn()}) {
                            TimerButton(label: "Break", buttonColor: .yellow, textColor: .black)
                        }
                    }
                }
                HStack(spacing: 2) {
                    StopwatchUnitView(timeUnit: stopWatchManager.hours)
                    Text(":")
                    StopwatchUnitView(timeUnit: stopWatchManager.minutes)
                    Text(":")
                    StopwatchUnitView(timeUnit: stopWatchManager.seconds)
                }
                .font(.custom("Avenir", size:40))
                HStack{
                    Text("Break")
                        .font(.system(size: 30))
                    if stopWatchManager.mode == .breakOn {
                        
                        Button(action: {self.stopWatchManager.breakOff()}) {
                            TimerButton(label: "Study", buttonColor: .yellow, textColor: .black)
                        }
                    }
                }
                HStack(spacing: 2) {
                    StopwatchUnitView(timeUnit: stopWatchManager.hours_2)
                    Text(":")
                    StopwatchUnitView(timeUnit: stopWatchManager.minutes_2)
                    Text(":")
                    StopwatchUnitView(timeUnit: stopWatchManager.seconds_2)
                }
                .font(.custom("Avenir", size: 40))
                
                if stopWatchManager.mode == .stopped{
                    Button(action: {self.stopWatchManager.Start()}) {
                        TimerButton(label: "Start", buttonColor: .yellow, textColor: .black)
                    }
                }
                if stopWatchManager.mode == .running {
                    
                    Button("Finish") {
                        showModal.toggle()
                    }.font(.largeTitle)
                        .sheet(isPresented: $showModal) {
                            SheetView(showModal: $showModal)
                        }
                }
                
                if stopWatchManager.mode == .breakOn {
                    
                    Button("Finish") {
                        showModal.toggle()
                    }.font(.largeTitle)
                        .sheet(isPresented: $showModal) {
                            SheetView(showModal: $showModal)
                        }
                }
                if stopWatchManager.mode == .breakOff {
                    
                    Button("Finish") {
                        showModal.toggle()
                    }.font(.largeTitle)
                        .sheet(isPresented: $showModal) {
                            SheetView(showModal: $showModal)
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
            .font(.system(size: 40))
            .foregroundColor(textColor)
            .background(buttonColor)
            .cornerRadius(10)
    }
}
