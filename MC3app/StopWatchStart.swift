//
//  StopWatchStart.swift
//  MC3app
//
//  Created by Aryan Garg on 21/02/23.
//

import SwiftUI

struct StopWatchStart: View {
    
    @ObservedObject var stopWatchManager = StopWatchManager()
    
    var body: some View {
        NavigationStack{
        
                NavigationLink(destination: StopWatch()
                    .navigationBarBackButtonHidden(true)) {
                        Text("\nStudy Time\n")
                    }
                    .isDetailLink(true)
                    .foregroundColor(Color.black)
                    .font(.system(size:25, weight:.medium))
                    .offset(y:200)
                    .buttonStyle(.bordered)
            }
        }
    }

struct StopWatchStart_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchStart()
    }
}
