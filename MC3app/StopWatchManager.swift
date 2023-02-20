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
        case stopped
        case paused
    }
    
    @Published var mode : stopWatchMode = .stopped
    
    @Published  var secondsElapsed = 0.0
    var timer = Timer()
    
    func Start(){
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.secondsElapsed += 0.1
        }
    }
    
    func pause(){
        timer.invalidate()
        mode = .paused
    }
    
    func stop(){
        timer.invalidate()
        secondsElapsed = 0
        mode = .stopped
    }
}

