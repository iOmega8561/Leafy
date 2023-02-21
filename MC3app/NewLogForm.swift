//
//  NewLogForm.swift
//  MC3app
//
//  Created by Giuseppe Rocco on 21/02/23.
//

import SwiftUI
import CoreData

let loremipsum = """
Lorem ipsum dolor sit amet
consectetur adipiscing elit.
Morbi in ex eleifend, faucibus
libero ac, lobortis leo.
"""

struct NewItem {
    var timestamp: Date = Date()

    var emotion: Int16 = 0
    var subject: String = ""
    var saynicetoyou: String = ""
    var totalbreaktime: Float = 0
    var totalstudytime: Float = 0
    var whatdidyoustudy: String = ""
    var writemore: String = ""
}

struct BackButton: View {
    var label: String
    var action: ()->Void
    var type: Int
    
    var body: some View {
        
        Button(action: action) {
            Rectangle()
                .fill(type == 1 ? .red:.green)
                .opacity(0.9)
                .overlay() {
                    Text(label)
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.bold)
                }
                .frame(width: 90.0, height: 30.0)
                .cornerRadius(20.0)
                .shadow(radius: 5.0)
        }
    }
}

struct NewLogForm: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showSheet = false
    
    
    var body: some View {
        NavigationStack {
            Button("Present") {
                showSheet.toggle()
            }.font(.largeTitle)
                .sheet(isPresented: $showSheet) {
                    SheetView()
                }
            
            NavigationLink(destination: ContentView().environment(\.managedObjectContext, viewContext)) {
                Text("LIST")
            }
        }
    }
}

struct SheetView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedEmotion: Int16 = 0
    @State var item: NewItem = NewItem()
    
    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                ScrollView {
                    HStack {
                        Spacer().frame(maxWidth: 30.0)
                        Text("Subject/s").font(.system(size: 30.0, weight: .bold))
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        TextField(loremipsum, text: $item.subject)
                            .padding(10)
                            .font(.system(size: 20.0))
                            .frame(maxWidth: proxy.size.width * 0.85, minHeight: 50)
                            .cornerRadius(10.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(Color.black, lineWidth: 2.5)
                            )
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer().frame(maxWidth: 30.0)
                        
                        Text("More in deep").font(.system(size: 30.0, weight: .bold))
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        TextField(loremipsum, text: $item.whatdidyoustudy)
                            .padding(10)
                            .font(.system(size: 20.0))
                            .frame(maxWidth: proxy.size.width * 0.85, minHeight: 50)
                            .cornerRadius(10.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(Color.black, lineWidth: 2.5)
                            )
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer().frame(maxWidth: 30.0)
                        
                        Text("How do you feel?").font(.system(size: 30.0, weight: .bold))
                        
                        Spacer()
                    }
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            
                            ForEach(1..<9) { n in
                                Button(action: {selectedEmotion = Int16(n) }) {
                                    Image(systemName: "cloud")
                                        .renderingMode(.template)
                                        .resizable()
                                        .foregroundColor(n == selectedEmotion ? .green:.black)
                                        .scaledToFit()
                                        .frame(width: 70.0)
                                }
                            }
                            
                        }
                    }
                    .frame(maxWidth: proxy.size.width * 0.85, minHeight: 70.0)
                    .transition(.move(edge: .bottom))
                    .cornerRadius(10.0)
                    .shadow(radius: 10.0)
                    
                    
                    
                    HStack {
                        Spacer().frame(maxWidth: 30.0)
                        Text("Write something more").font(.system(size: 30.0, weight: .bold))
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        TextField(loremipsum, text: $item.writemore, axis: .vertical)
                            .lineLimit(5)
                            .padding(10)
                            .font(.system(size: 20.0))
                            .frame(maxWidth: proxy.size.width * 0.85, minHeight: 50)
                            .cornerRadius(10.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(Color.black, lineWidth: 2.5)
                            )
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer().frame(maxWidth: 30.0)
                        Text("Something nice for you!").font(.system(size: 30.0, weight: .bold))
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        TextField(loremipsum, text: $item.saynicetoyou, axis: .vertical)
                            .lineLimit(5)
                            .padding(10)
                            .font(.system(size: 20.0))
                            .frame(maxWidth: proxy.size.width * 0.85, minHeight: 50)
                            .cornerRadius(10.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(Color.black, lineWidth: 2.5)
                            )
                        
                        Spacer()
                    }
                }
                .navigationTitle("New Log")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                        BackButton(label: "Back  ", action: { dismiss() }, type: 1)
                    }
                    
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        BackButton(label: "Save  ", action: { saveItem(item: item)}, type: 0)
                    }
                }
            }
        }
    }
    
    private func saveItem(item: NewItem) {
        let newItem = Item(context: viewContext)
        newItem.timestamp = Date()
        newItem.emotion = item.emotion
        newItem.subject = item.subject
        newItem.saynicetoyou = item.saynicetoyou
        newItem.totalbreaktime = 30.0
        newItem.totalstudytime = 120.0
        newItem.whatdidyoustudy = item.whatdidyoustudy
        
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

struct NewLogForm_Previews: PreviewProvider {
    static var previews: some View {
        NewLogForm()
    }
}
