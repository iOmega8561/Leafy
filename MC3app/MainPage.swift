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
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationStack {
            ZStack {
                Color("background")
                
                VStack(spacing:20) {
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
                        .disabled(items.count == 0 ? true:false)
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
                    }.grayscale(items.count == 0 ? 0.8:0.0)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .accentColor(Color("TextColor"))
    }
}


struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
