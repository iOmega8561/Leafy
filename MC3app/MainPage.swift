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
            
            VStack(spacing:20){
                Image("Tree")
                    .offset(y:139)
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
                
            
                
                ZStack{
                  
                    
                    
                    NavigationLink(destination: LogList().environment(\.managedObjectContext, viewContext)) {
                        Text("       Cards                  ")
                    }
                    .background(Color("ButtonBackground"))
                    .cornerRadius(12)
                    .foregroundColor(Color("ButtonText"))
                    .font(.system(size:25, weight:.semibold))
                    .buttonStyle(.bordered)
                    .offset(x:40, y:-523)
                    
                   
                    
                    Image("LeafSmall")
                        .resizable()
                        .frame(width: 180, height: 180)
                        .offset(x:-31, y: -492)
                }
            }.background(Color("Background"))
                .edgesIgnoringSafeArea(.all)
        }
    }
}


struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
