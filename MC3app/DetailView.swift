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
    
    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                ScrollView {
                    VStack(spacing: 20.0) {
                        HStack {
                            Spacer().frame(maxWidth: 30.0)
                            Text(item.subject ?? "No subject!").font(.system(size: 34.0, weight: .bold))
                            Spacer()
                        }
                        
                        
                        
                        HStack {
                            Spacer().frame(maxWidth: 30.0)
                            
                            Text(item.whatdidyoustudy ?? "Nothing here!")
                                .font(.system(size: 20.0))
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                        }
                        
                        RoundedRectangle(cornerRadius: 10.0)
                            .frame(maxWidth: proxy.size.width * 0.85, minHeight: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 7.0)
                                    .frame(maxWidth: proxy.size.width * 0.83, maxHeight: 94)
                                    .foregroundColor(.white)
                                    .overlay(
                                        HStack {
                                            Spacer().frame(maxWidth: 20.0)
                                            
                                            Image(systemName: imgs[Int(item.emotion)])
                                                .resizable()
                                                .scaledToFit()
                                                .frame(maxWidth: 70.0)
                                            
                                            Spacer().frame(maxWidth: 15.0)
                                            
                                            VStack(spacing: 7.0) {
                                                Text("Study time:")
                                                    .font(.system(size: 20.0))
                                                
                                                Text("Break time:")
                                                    .font(.system(size: 20.0))
                                            }
                                            
                                            Spacer().frame(maxWidth: 10.0)
                                            
                                            VStack(spacing: 7.0) {
                                                Text("\(item.studyhours)h \(item.studyminutes)m")
                                                    .font(.system(size: 20.0))
                                                
                                                Text("\(item.breakhours)h \(item.breakminutes)m")
                                                    .font(.system(size: 20.0))
                                            }
                                            
                                            Spacer().frame(maxWidth: 40.0)
                                        }
                                    )
                            )
                        
                        
                        HStack {
                            Spacer().frame(maxWidth: 30.0)
                            Text("My feelings").font(.system(size: 34.0, weight: .bold))
                            Spacer()
                        }
                        
                        
                        
                        HStack {
                            Spacer().frame(maxWidth: 30.0)
                            
                            Text(item.writemore ?? "Nothing here!")
                                .font(.system(size: 20.0))
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Spacer().frame(maxWidth: 30.0)
                            Text("Kind words for myself").font(.system(size: 34.0, weight: .bold))
                            Spacer()
                        }
                        
                        
                        
                        HStack {
                            Spacer().frame(maxWidth: 30.0)
                            
                            Text(item.saynicetoyou ?? "Nothing here!")
                                .font(.system(size: 20.0))
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                        }
                    }
                    .navigationTitle("Log Details")
                    .navigationBarTitleDisplayMode(.inline)
                    
                }}
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        LogList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
