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
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.secondsElapsed += 1
        }
    }
    
    func breakOn(){
        timer.invalidate()
        mode = .breakOn
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.studyBreak += 1
        }
    }
    
    func breakOff(){
        timer.invalidate()
        mode = .breakOff
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
            self.secondsElapsed += 1
        }
    }
    
    func stop(){
        timer.invalidate()
        secondsElapsed = 0
        studyBreak = 0
        mode = .stopped
    }
}
