//
//  StopWatchManager.swift
//  MC3app
//
//  Created by Aryan Garg on 20/02/23.
//

import Foundation
import SwiftUI

class StopWatchManager: ObservableObject{
    
    enum stopWatchMode{
        case running
        case breakOn
        case breakOff
        case stopped
    }
    
    @Published var mode : stopWatchMode = .stopped
    
    @Published  var secondsElapsed = 0
    
    @Published var studyBreak = 0
    
    var hours: Int {
        secondsElapsed / 3600
    }
    
    var minutes: Int {
        (secondsElapsed % 3600) / 60
    }
    
    var seconds: Int {
        secondsElapsed % 60
    }
    
    var hours_2: Int {
        studyBreak / 3600
    }
    
    var minutes_2: Int {
        (studyBreak % 3600) / 60
    }
    
    var seconds_2: Int {
        studyBreak % 60
    }
    
    var timer = Timer()
    
    func Start(){
        timer.invalidate()
        let currenttime = Date()
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.secondsElapsed = self.updateTimer(date: currenttime)
        }
    }
    
    func breakOn(){
        timer.invalidate()
        
        let breaks = self.studyBreak
        
        let currentTime = Date()
        mode = .breakOn
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.studyBreak = self.updateTimer(date: currentTime) + breaks
        }
    }
    
    func breakOff(){
        timer.invalidate()
        
        let seconds = self.secondsElapsed
        
        let currentTime = Date()
        
        mode = .breakOff
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
            self.secondsElapsed = updateTimer(date: currentTime) + seconds
        }
    }
    
    func stop(){
        timer.invalidate()
        secondsElapsed = 0
        studyBreak = 0
        mode = .stopped
    }
    
    func updateTimer(date : Date) -> Int{
        
        let update = Calendar.current.dateComponents([.second], from: date , to: Date())
        
        let second = update.second ?? 0
        
        return second
    }
}
