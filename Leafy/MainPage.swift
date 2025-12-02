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
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
                  animation: .default)
    
    private var items: FetchedResults<Item>
    
    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                ZStack {
                    Color("background")
                    
                    VStack() {
                        
                        HStack {
                            Spacer()
                            
                            NavigationLink(destination: LogList().environment(\.managedObjectContext, viewContext)) {
                                
                                ZStack {
                                    Text("main_loglist")
                                        .font(.system(size:25, weight:.semibold))
                                        .foregroundColor(items.count == 0 ?  .gray:Color("ButtonText"))
                                        .frame(minWidth: 180.0, minHeight: 40.0)
                                        .background(Color("ButtonBackground"))
                                        .cornerRadius(12)
                                        .offset(x:40, y: 13)
                                    Image("LeafSmall")
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                        .scaledToFit()
                                        .frame(width: 120)
                                        .offset(x:-30, y: 30)
                                }
                                
                            }
                            .disabled(items.count == 0 ? true:false)
                            .grayscale(items.count == 0 ? 0.8:0.0)
                            
                            Spacer().frame(maxWidth: proxy.size.width * 0.17)
                        }
                        
                        Spacer().frame(maxHeight: 100.0)
                        
                        VStack(spacing: -20) {
                            Image("Tree")
                            NavigationLink(destination: StopWatchREDUX().environment(\.managedObjectContext, viewContext)
                                .navigationBarBackButtonHidden(true)) {
                                    Text("main_startsession")
                                        .font(.system(size:30, weight:.semibold))
                                        .foregroundColor(Color("ButtonText"))
                                }
                                .isDetailLink(true)
                                .frame(minWidth: proxy.size.width * 0.9, minHeight: proxy.size.height * 0.12)
                                .background(Color("ButtonBackground"))
                                .cornerRadius(12)
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
            .accentColor(Color("TextColor"))
        }
    }
}
