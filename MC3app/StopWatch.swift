//
//  StopWatch.swift
//  MC3app
//
//  Created by Aryan Garg on 21/02/23.
//

import SwiftUI

var backBTN: some View {
    
    NavigationLink(destination: MainPage().navigationBarBackButtonHidden(true)) {
        HStack {
            Image(systemName: "chevron.backward")
                .renderingMode(.template)
                .foregroundColor(Color("TextColor"))
            Text("button_back")
                .foregroundColor(Color("TextColor"))
        }
    }
}

struct StopWatch: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var stopWatchManager = StopWatchManager()
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack{
                    if stopWatchManager.mode == .running || stopWatchManager.mode == .breakOff || stopWatchManager.mode == .stopped{
                        HStack{
                            Text("Study Time")
                                .font(.system(size: 30))
                            
                            
                            if stopWatchManager.mode == .running || stopWatchManager.mode == .breakOff  {
                                
                                Button(action: {self.stopWatchManager.breakOn()}) {
                                    TimerButton(label: "Break", buttonColor: .yellow, textColor: .black)
                                }
                            }
                            
                            if stopWatchManager.mode == .stopped || stopWatchManager.mode == .breakOn{
                                Button(action:{}){
                                    TimerButton(label: "Break", buttonColor: .gray, textColor: .white)
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
                    }
                }.position(x:150, y: 150)
                
                VStack{
                    
                    if stopWatchManager.mode == .breakOn {
                        HStack{
                            Text("Break")
                                .font(.system(size: 30))
                            if stopWatchManager.mode == .breakOn {
                                
                                Button(action: {self.stopWatchManager.breakOff()}) {
                                    TimerButton(label: "Study", buttonColor: .yellow, textColor: .black)
                                }
                            }
                            //                            if stopWatchManager.mode == .stopped || stopWatchManager.mode == .breakOff ||
                            //                                stopWatchManager.mode == .running{
                            //                                Button(action:{}){
                            //                                    TimerButton(label: "Break", buttonColor: .gray, textColor: .black)
                            //                                }
                            //                            }
                        }
                        HStack(spacing: 2) {
                            StopwatchUnitView(timeUnit: stopWatchManager.hours_2)
                            Text(":")
                            StopwatchUnitView(timeUnit: stopWatchManager.minutes_2)
                            Text(":")
                            StopwatchUnitView(timeUnit: stopWatchManager.seconds_2)
                        }
                        .font(.custom("Avenir", size: 40))
                    }
                }.position(x:150, y: 20)
                if stopWatchManager.mode == .stopped{
                    Button(action: {self.stopWatchManager.Start()}) {
                        TimerButton(label: "Start", buttonColor: .yellow, textColor: .black)
                    }
                }
                if stopWatchManager.mode == .running || stopWatchManager.mode == .breakOn || stopWatchManager.mode == .breakOff {
                    
                    NavigationLink(destination: LogList(showModal: true, studyhours: Int16(stopWatchManager.hours), studyminutes: Int16(stopWatchManager.minutes), studyseconds: Int16(stopWatchManager.seconds), breakhours: Int16(stopWatchManager.hours_2), breakminutes: Int16(stopWatchManager.minutes_2), breakseconds: Int16(stopWatchManager.seconds_2))
                        .environment(\.managedObjectContext, viewContext)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: backBTN)) {
                        Text("Finish").font(.largeTitle)
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
