//
//  NewLogForm.swift
//  MC3app
//
//  Created by Giuseppe Rocco on 21/02/23.
//

import SwiftUI
import CoreData

struct NewLogForm: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationStack {
            
            NavigationLink(destination: StopWatch()
                .navigationBarBackButtonHidden(true)) {
                    Text("\nStudy Time\n")
                }
                .isDetailLink(true)
                .foregroundColor(Color.black)
                .font(.system(size:25, weight:.medium))
                .offset(y:200)
                .buttonStyle(.bordered)
            
            NavigationLink(destination: ContentView().environment(\.managedObjectContext, viewContext)) {
                Text("LIST")
            }
        }
    }
}


struct NewLogForm_Previews: PreviewProvider {
    static var previews: some View {
        NewLogForm()
    }
}
