////
////  SheetView.swift
////  MC3app
////
////  Created by Aryan Garg on 21/02/23.
////
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
    var whatdidyoustudy: String = ""
    var writemore: String = ""
}

struct CustomButton: View {
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

struct SheetView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedEmotion: Int16 = 0
    @State var item: NewItem = NewItem()
    
    @Binding var isShown: Bool
    
    var studyhours: Int16 = 0
    var studyminutes: Int16 = 0
    var studyseconds: Int16 = 0
    var breakhours: Int16 = 0
    var breakminutes: Int16 = 0
    var breakseconds: Int16 = 0
    
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
                        CustomButton(label: "Back  ", action: { isShown = false/*; dismiss()*/ }, type: 1)
                    }
                    
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        CustomButton(label: "Save  ", action: { saveItem(item: item, shours: studyhours, sminutes: studyminutes, sseconds: studyseconds, bhours: breakhours, bminutes: breakminutes, bseconds: breakseconds); isShown = false/*; dismiss()*/ }, type: 0)
                    }
                }
            }
        }
    }
    
    private func saveItem(item: NewItem, shours: Int16, sminutes: Int16, sseconds: Int16, bhours: Int16, bminutes: Int16, bseconds: Int16) {
        let newItem = Item(context: viewContext)
        newItem.timestamp = Date()
        newItem.emotion = item.emotion
        newItem.subject = item.subject
        newItem.saynicetoyou = item.saynicetoyou
        newItem.whatdidyoustudy = item.whatdidyoustudy
        newItem.studyhours = shours
        newItem.studyminutes = sminutes
        newItem.studyseconds = sseconds
        newItem.breakhours = bhours
        newItem.breakminutes = bminutes
        newItem.breakseconds = bseconds

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

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(isShown: .constant(false))
    }
}


