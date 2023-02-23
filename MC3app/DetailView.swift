//
//  DetailView.swift
//  MC3app
//
//  Created by Aryan Garg on 22/02/23.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var item: FetchedResults<Item>.Element

    init(item: FetchedResults<Item>.Element) {
        self.item = item
        
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color("TextColor"))]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color("TextColor"))]
    }
    
    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                ZStack {
                    Color("background")
                    
                    VStack() {
                        Spacer().frame(maxHeight: 150.0)
                        
                        Image(imgs[Int(item.emotion)])
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 110.0)
                        
                        HStack {
                            VStack(spacing: 7.0) {
                                Text("details_studytime")
                                    .font(.system(size: 20.0))
                                    .foregroundColor(Color("TextColor"))
                                
                                Text("details_breaktime")
                                    .font(.system(size: 20.0))
                                    .foregroundColor(Color("TextColor"))
                            }
                            
                            Spacer().frame(maxWidth: 10.0)
                            
                            VStack(spacing: 7.0) {
                                Text("\(item.studyhours)h \(item.studyminutes)m")
                                    .font(.system(size: 20.0))
                                    .foregroundColor(Color("TextColor"))
                                
                                Text("\(item.breakhours)h \(item.breakminutes)m")
                                    .foregroundColor(Color("TextColor"))
                                    .font(.system(size: 20.0))
                            }
                        }
                        
                        ScrollView {
                            VStack(spacing: 20.0) {
                                Spacer().frame(maxWidth: 30.0)
                                
                                Spacer().frame(maxWidth: 30.0)
                                
                                HStack {
                                    Spacer().frame(maxWidth: 30.0)
                                    Text(item.subject ?? "No subject!")
                                        .font(.system(size: 34.0, weight: .bold))
                                        .foregroundColor(Color("TextColor"))
                                    Spacer()
                                }
                                
                                
                                
                                HStack {
                                    Spacer().frame(maxWidth: 30.0)
                                    
                                    Text(item.whatdidyoustudy ?? "Nothing here!")
                                        .font(.system(size: 20.0))
                                        .foregroundColor(Color("TextColor"))
                                        .multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                }
                                
                                if item.writemore != nil && item.writemore != "" {
                                    
                                    HStack {
                                        Spacer().frame(maxWidth: 30.0)
                                        Text("details_writemore")
                                            .font(.system(size: 34.0, weight: .bold))
                                            .foregroundColor(Color("TextColor"))
                                        Spacer()
                                    }
                                    
                                    
                                    
                                    HStack {
                                        Spacer().frame(maxWidth: 30.0)
                                        
                                        Text(item.writemore ?? "Error retrieving data!")
                                            .font(.system(size: 20.0))
                                            .foregroundColor(Color("TextColor"))
                                            .multilineTextAlignment(.leading)
                                        
                                        Spacer()
                                    }
                                }
                                
                                if item.saynicetoyou != nil && item.saynicetoyou != "" {
                                    
                                    HStack {
                                        Spacer().frame(maxWidth: 30.0)
                                        Text("details_nicewords")
                                            .foregroundColor(Color("TextColor"))
                                            .font(.system(size: 34.0, weight: .bold))
                                        Spacer()
                                    }
                                    
                                    
                                    
                                    HStack {
                                        Spacer().frame(maxWidth: 30.0)
                                        
                                        Text(item.saynicetoyou ?? "Error retrieving data!")
                                            .font(.system(size: 20.0))
                                            .foregroundColor(Color("TextColor"))
                                            .multilineTextAlignment(.leading)
                                        
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .navigationTitle("details_title")
                        .navigationBarTitleDisplayMode(.inline)
                    }
                }.ignoresSafeArea()
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        LogList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
