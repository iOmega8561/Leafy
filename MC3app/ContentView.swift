//
//  ContentView.swift
//  MC3app
//
//  Created by Giuseppe Rocco on 20/02/23.
//

import SwiftUI
import CoreData

/*struct RecentAuths: View {
    var colorScheme: ColorScheme
    var geometry: GeometryProxy
    
    private func noPurposeFunction(rowC: Int) -> CGFloat {
        if rowC < 6 { return 45.0}
        
        else if rowC < 10 { return 44.0 }
        
        else if rowC <= 15 { return 43.0 }
        
        else { return 42.7 }
    }
    
    private func calcMaxHeight() -> CGFloat {
        var width: CGFloat
        let dataCount: CGFloat = CGFloat(sampleData.count)
        
        let superIncredibleMath = dataCount - (dataCount == 1.0 ? 0.0:(0.1 * dataCount))
        
        width = superIncredibleMath * noPurposeFunction(rowC: sampleData.count)
        if width > (geometry.size.height * 0.8) {
            width = geometry.size.height * 0.8
        }
        
        return width
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            Rectangle()
                .fill(Color("PosteYellow"))
                .opacity(0.9)
                .overlay() {
                    
                    ScrollView {
                        VStack {
                            Spacer()
                            ForEach(sampleData) { auth in
                                ScrollViewElement(colorScheme: colorScheme, auth: auth)
                            }
                        }.frame(maxWidth: UIDevice.current.localizedModel == "iPhone" ? 340.0:700.0)
                    }
                }
                .frame(maxWidth: UIDevice.current.localizedModel == "iPhone" ? 340.0:700.0, maxHeight: calcMaxHeight())
                .cornerRadius(20.0)
                .shadow(color: Color("PosteYellow"), radius: 4)
            
            Spacer()
        }
    }
}*/

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
                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                    } label: {
                        HStack {
                            VStack {
                                Image(systemName: "cloud.moon.rain")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 50.0)
                                
                                Spacer().frame(maxHeight: 6.0)
                                
                                Text(item.timestamp!, formatter: itemFormatter)
                            }
                            Spacer().frame(maxWidth: 60.0)
                            VStack {
                                
                                Text("Subject Name").font(.system(size: 23.0))
                                
                                Spacer().frame(maxHeight: 6.0)
                                
                                Text("Chapter/Topic")
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
            offsets.map { items[$0] }.forEach(viewContext.delete)

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
