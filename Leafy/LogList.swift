//
//  ContentView.swift
//  MC3app
//
//  Created by Giuseppe Rocco on 20/02/23.
//

import SwiftUI
import CoreData

let imgs = [
    "angry",
    "happy",
    "sad",
    "surprised",
    "tired"
]

struct LogList: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
                  animation: .default)
    
    private var items: FetchedResults<Item>
    
    @State var showModal: Bool
    
    var studyhours: Int16 = 0
    var studyminutes: Int16 = 0
    var studyseconds: Int16 = 0
    var breakhours: Int16 = 0
    var breakminutes: Int16 = 0
    var breakseconds: Int16 = 0
    
    init(showModal: Bool = false,
         studyhours: Int16 = 0,
         studyminutes: Int16 = 0,
         studyseconds: Int16 = 0,
         breakhours: Int16 = 0,
         breakminutes: Int16 = 0,
         breakseconds: Int16 = 0) {
        
        self._showModal = State(initialValue: showModal)
        self.studyhours = studyhours
        self.studyminutes = studyminutes
        self.studyseconds = studyseconds
        self.breakhours = breakhours
        self.breakminutes = breakminutes
        self.breakseconds = breakseconds
        
        
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color("TextColor"))
        ]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor(Color("TextColor"))
        ]
    }
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(items) { item in
                    
                    NavigationLink(destination: DetailView(item: item)) {
                        HStack {
                            VStack {
                                Image(imgs[Int(item.emotion)])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 50.0)
                                
                                Spacer().frame(maxHeight: 6.0)
                                
                                Text(item.timestamp!, formatter: itemFormatter)
                                    .foregroundColor(Color("TextColor"))
                            }
                            Spacer().frame(maxWidth: 20.0)
                            VStack {
                                
                                HStack {
                                    Text(item.subject!)
                                        .font(.system(size: 23.0))
                                        .foregroundColor(Color("TextColor"))
                                    Spacer()
                                }
                                
                                Spacer().frame(maxHeight: 6.0)
                                
                                HStack {
                                    Text("\(item.studyhours)h \(item.studyminutes)m \(item.studyseconds)s")
                                        .foregroundColor(Color("TextColor"))
                                    Spacer()
                                }
                                
                            }
                        }
                    }
                    .listRowSeparatorTint(Color("TextColor"))
                    .listRowSeparator(.automatic)
                    .listRowBackground(Color(red: 0.973, green: 0.973, blue: 0.968))
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("title_loglist")
            .background(Color("background"))
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .foregroundColor(Color("TextColor"))
                }
            }
            .sheet(isPresented: $showModal) {
                SheetView(isShown: $showModal,
                          studyhours: studyhours,
                          studyminutes: studyminutes,
                          studyseconds: studyseconds,
                          breakhours: breakhours,
                          breakminutes: breakminutes,
                          breakseconds: breakseconds)
            }
        }.accentColor(Color("TextColor"))
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let template = "MMMdd"
    let format = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: NSLocale.current)
    
    
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    formatter.dateFormat = format
    
    return formatter
}()
