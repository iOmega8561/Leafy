//
//  ContentView.swift
//  MC3app
//
//  Created by Giuseppe Rocco on 20/02/23.
//

import SwiftUI
import CoreData

let imgs = [
"cloud.moon.rain",
"cloud"
]

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text(item.saynicetoyou!)
                    } label: {
                        HStack {
                            VStack {
                                Image(systemName: imgs[Int(item.emotion)])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 50.0)
                                
                                Spacer().frame(maxHeight: 6.0)
                                
                                Text(item.timestamp!, formatter: itemFormatter)
                            }
                            Spacer().frame(maxWidth: 60.0)
                            VStack {
                                
                                Text(item.subject!).font(.system(size: 23.0))
                                
                                Spacer().frame(maxHeight: 6.0)
                                
                                Text(item.whatdidyoustudy!)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
            
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.emotion = 0
            newItem.subject = "Some Subject"
            newItem.saynicetoyou = "Something Nice to You"
            newItem.totalbreaktime = 30.0
            newItem.totalstudytime = 120.0
            newItem.whatdidyoustudy = "What did u study"

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            //offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
