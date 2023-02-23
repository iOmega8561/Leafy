//
//  NewLogForm.swift
//  MC3app
//
//  Created by Giuseppe Rocco on 21/02/23.
//

import SwiftUI
import CoreData

struct MainPage: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationStack {
            
            VStack{
                Image("Tree")
                    .offset(y:127)
                NavigationLink(destination: StopWatch()) {
                    Text("\nNew Study Session\n")
                }
                .isDetailLink(true)
                .background(Color("ButtonBackground"))
                .cornerRadius(12)
                .foregroundColor(Color("ButtonText"))
                .font(.system(size:25, weight:.semibold))
                .offset(y:100)
                .buttonStyle(.bordered)
               
                
                NavigationLink(destination: LogList().environment(\.managedObjectContext, viewContext)) {
                    Text("LIST")
                }.offset(y:-523)
            }
        }.accentColor(Color("TextColor"))
    }
}


struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
