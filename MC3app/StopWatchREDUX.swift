//
//  StopWatchREDUX.swift
//  MC3app
//
//  Created by Giuseppe Rocco on 24/02/23.
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

struct StopWatchREDUX: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var stopWatchManager = StopWatchManager()
    
    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                ZStack {
                    Color("background")
                    
                    VStack {
                        Spacer().frame(maxHeight: 60.0)
                        RoundedRectangle(cornerRadius: 15.0)
                            .frame(maxWidth: proxy.size.width * 0.95, maxHeight: proxy.size.height * 0.85)
                            .foregroundColor(Color("BackgroundCard"))
                            .overlay(
                                VStack {
                                    Spacer().frame(maxHeight: 40.0)
                                    
                                    Text("stopwatch_studytime")
                                        .font(.system(size: 40.0, weight: .semibold))
                                        .foregroundColor(Color("TextColor"))
                                    
                                    Spacer().frame(maxHeight: 5.0)
                                    
                                    HStack(spacing: 2) {
                                        StopwatchUnitView(type: 0, timeUnit: stopWatchManager.hours)
                                        Text(":")
                                        StopwatchUnitView(type: 0, timeUnit: stopWatchManager.minutes)
                                        Text(":")
                                        StopwatchUnitView(type: 0, timeUnit: stopWatchManager.seconds)
                                    }
                                    .font(.system(size:70, weight: .semibold))
                                    .foregroundColor(Color("TextColor"))
                                    
                                    Spacer()
                                    
                                    HStack {
                                        VStack {
                                            Text("stopwatch_breaktime")
                                                .font(.system(size: 30.0, weight: .semibold))
                                                .foregroundColor(Color("TextColor"))
                                            
                                            Spacer().frame(maxHeight: 5.0)
                                            
                                            HStack(spacing: 2) {
                                                StopwatchUnitView(type: 1, timeUnit: stopWatchManager.hours_2)
                                                Text(":")
                                                StopwatchUnitView(type: 1, timeUnit: stopWatchManager.minutes_2)
                                                Text(":")
                                                StopwatchUnitView(type: 1, timeUnit: stopWatchManager.seconds_2)
                                            }
                                            .font(.system(size:30, weight: .semibold))
                                            .foregroundColor(Color("TextColor"))
                                        }.frame(width: 190.0)
                                        
                                        Spacer().frame(maxWidth: 60.0)
                                        
                                        Button(action: {
                                            if stopWatchManager.mode == .breakOn {
                                                self.stopWatchManager.breakOff()
                                            } else {
                                                self.stopWatchManager.breakOn()
                                            }
                                        }) {
                                            Image(systemName: stopWatchManager.mode == .breakOn ? "pause.fill":"play.fill")
                                                .renderingMode(.template)
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(stopWatchManager.mode == .stopped ? .gray:Color("ButtonText"))
                                                .frame(maxWidth: 25.0)
                                        }
                                        .disabled(stopWatchManager.mode == .stopped)
                                        .frame(minWidth: 60.0, minHeight: 50.0)
                                        .background(Color("ButtonBackground"))
                                        .cornerRadius(6.0)
                                        .grayscale(stopWatchManager.mode == .stopped ? 1.0:0.0)
                                        
                                        Spacer().frame(maxWidth: 20.0)
                                    }
                                    
                                    Spacer()
                                    
                                    Image("LeafGroup")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: proxy.size.width * 0.87)
                                    
                                    Spacer().frame(maxHeight: 40.0)
                                }
                            )
                        
                        Spacer().frame(maxHeight: 20.0)
                        
                        if stopWatchManager.mode == .running || stopWatchManager.mode == .breakOn || stopWatchManager.mode == .breakOff {
                            
                            NavigationLink(destination: LogList(showModal: true, studyhours: Int16(stopWatchManager.hours), studyminutes: Int16(stopWatchManager.minutes), studyseconds: Int16(stopWatchManager.seconds), breakhours: Int16(stopWatchManager.hours_2), breakminutes: Int16(stopWatchManager.minutes_2), breakseconds: Int16(stopWatchManager.seconds_2))
                                .environment(\.managedObjectContext, viewContext)
                                .navigationBarBackButtonHidden(true)
                                .navigationBarItems(leading: backBTN)) {
                                Text("stopwatch_finish")
                                        .font(.system(size: 35, weight: .semibold))
                                        .foregroundColor(Color("ButtonText"))
                            }
                            .frame(maxWidth: proxy.size.width * 0.4, maxHeight: proxy.size.height * 0.09)
                            .background(Color("ButtonBackground"))
                            .cornerRadius(10.0)
                            
                        } else {
                            
                            Button(action: {self.stopWatchManager.Start()}) {
                                Text("stopwatch_start")
                                    .font(.system(size: 35, weight: .semibold))
                                    .foregroundColor(Color("ButtonText"))
                            }
                            .frame(maxWidth: proxy.size.width * 0.4, maxHeight: proxy.size.height * 0.09)
                            .background(Color("ButtonBackground"))
                            .cornerRadius(10.0)
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
            .accentColor(Color("TextColor"))
        }
    }
}

struct StopwatchUnitView: View {
    var type: Int
    var timeUnit: Int

    /// Time unit expressed as String.
    /// - Includes "0" as prefix if this is less than 10
    var timeUnitStr: String {
        let timeUnitStr = String(timeUnit)
        return timeUnit < 10 ? "0" + timeUnitStr : timeUnitStr
    }

    var body: some View {
        HStack (spacing: 2) {
            Text(timeUnitStr.substring (index: 0)).frame(width: type == 0 ? 42:20)
            Text(timeUnitStr.substring(index: 1)).frame(width: type == 0 ? 42:20)
        }
    }
}

extension String {
    func substring(index: Int) -> String {
        let arrayString = Array(self)
        return String(arrayString[index])
    }
}

struct StopWatchREDUX_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchREDUX()
    }
}
