////
////  SheetView.swift
////  MC3app
////
////  Created by Aryan Garg on 21/02/23.
////
//
import SwiftUI
import CoreData

struct NewItem {
    var timestamp: Date = Date()

    var emotion: Int16 = 0
    var subject: String = ""
    var saynicetoyou: String = ""
    var whatdidyoustudy: String = ""
    var writemore: String = ""
}

struct CustomButton: View {
    var label: LocalizedStringKey
    var action: ()->Void
    var type: Int
    
    var body: some View {
        
        Button(action: action) {
            if type == 1 {
                Image(systemName: "chevron.backward")
                    .renderingMode(.template)
                    .foregroundColor(Color("TextColor"))
            }
            
            Text(label)
                .foregroundColor(Color("TextColor"))
        }
    }
}

struct SheetView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State private var actionSheet: Bool = false
    @State var item: NewItem = NewItem()
    
    @State var triedToSave: Bool = false
    
    @Binding var isShown: Bool
    
    var studyhours: Int16 = 0
    var studyminutes: Int16 = 0
    var studyseconds: Int16 = 0
    var breakhours: Int16 = 0
    var breakminutes: Int16 = 0
    var breakseconds: Int16 = 0
    
    
    init(isShown: Binding<Bool>, studyhours: Int16 = 0, studyminutes: Int16 = 0, studyseconds: Int16 = 0, breakhours: Int16 = 0, breakminutes: Int16 = 0, breakseconds: Int16 = 0) {
        
        self._isShown = isShown
        self.studyhours = studyhours
        self.studyminutes = studyminutes
        self.studyseconds = studyseconds
        self.breakhours = breakhours
        self.breakminutes = breakminutes
        self.breakseconds = breakseconds
        
        
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color("TextColor"))]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color("TextColor"))]
    }
    
    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                ScrollView {
                    HStack {
                        Spacer().frame(maxWidth: 30.0)
                        Text("sheet_subject")
                            .font(.system(size: 30.0, weight: .bold))
                            .foregroundColor(Color("TextColor"))
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        TextField("sheet_mandatory", text: $item.subject)
                            .foregroundColor(Color("TextColor"))
                            .padding(10)
                            .font(.system(size: 20.0))
                            .frame(maxWidth: proxy.size.width * 0.85, minHeight: 50)
                            .cornerRadius(10.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(triedToSave == true ? Color("Destructive"):Color("TextColor"), lineWidth: 2.5)
                            )
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer().frame(maxWidth: 30.0)
                        
                        Text("sheet_whatdidustudy")
                            .font(.system(size: 30.0, weight: .bold))
                            .foregroundColor(Color("TextColor"))
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        TextField("sheet_mandatory", text: $item.whatdidyoustudy)
                            .foregroundColor(Color("TextColor"))
                            .padding(10)
                            .font(.system(size: 20.0))
                            .frame(maxWidth: proxy.size.width * 0.85, minHeight: 50)
                            .cornerRadius(10.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(triedToSave == true ? Color("Destructive"):Color("TextColor"), lineWidth: 2.5)
                            )
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer().frame(maxWidth: 30.0)
                        
                        Text("sheet_howdoyoufeel")
                            .font(.system(size: 30.0, weight: .bold))
                            .foregroundColor(Color("TextColor"))
                        
                        Spacer()
                    }
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            
                            ForEach(0..<5) { n in
                                VStack {
                                    Button(action: {item.emotion = Int16(n) }) {
                                        Image(imgs[n])
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 90.0)
                                    }
                                    
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .foregroundColor(Color("ButtonBackground"))
                                        .frame(maxHeight: 25.0)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 7.0)
                                                .foregroundColor(item.emotion == Int16(n) ? Color("ButtonBackground"):.white)
                                                //.frame(maxWidth: 85.0, maxHeight: 20.0)
                                                .overlay(
                                                    Text(LocalizedStringKey(imgs[n]))
                                                        .foregroundColor(item.emotion == Int16(n) ? Color("ButtonText"):Color("TextColor"))
                                                )
                                        )
                                }
                            }
                            
                        }
                    }
                    .frame(maxWidth: proxy.size.width * 0.85, minHeight: 70.0)
                    .transition(.move(edge: .bottom))
                    .cornerRadius(10.0)
                    .shadow(color: Color("ButtonBackground"), radius: 2.0)
                    
                    
                    
                    HStack {
                        Spacer().frame(maxWidth: 30.0)
                        Text("sheet_writemore")
                            .font(.system(size: 30.0, weight: .bold))
                            .foregroundColor(Color("TextColor"))
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        TextField("sheet_writemore_placeholder", text: $item.writemore, axis: .vertical)
                            .foregroundColor(Color("TextColor"))
                            .lineLimit(5)
                            .padding(10)
                            .font(.system(size: 20.0))
                            .frame(maxWidth: proxy.size.width * 0.85, minHeight: 50)
                            .cornerRadius(10.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(Color("TextColor"), lineWidth: 2.5)
                            )
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer().frame(maxWidth: 30.0)
                        Text("sheet_saynice")
                            .font(.system(size: 30.0, weight: .bold))
                            .foregroundColor(Color("TextColor"))
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        TextField("sheet_nicewords_placeholder", text: $item.saynicetoyou, axis: .vertical)
                            .foregroundColor(Color("TextColor"))
                            .lineLimit(5)
                            .padding(10)
                            .font(.system(size: 20.0))
                            .frame(maxWidth: proxy.size.width * 0.85, minHeight: 50)
                            .cornerRadius(10.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(Color("TextColor"), lineWidth: 2.5)
                            )
                        
                        Spacer()
                    }
                }
                .background(Color("background"))
                .navigationTitle("title_newlog")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                        CustomButton(label: LocalizedStringKey("button_exit"), action: { actionSheet = true/*; dismiss()*/ }, type: 1)
                            .confirmationDialog("cdialog_text", isPresented: $actionSheet, titleVisibility: .visible) {
                                Button(role: .destructive) {
                                    do {
                                        try viewContext.save()
                                        actionSheet = false
                                        isShown = false
                                    } catch {
                                        let nsError = error as NSError
                                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                    }
                                } label: {
                                    Text("cdialog_confirm")
                                }
                            }
                    }
                    
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        CustomButton(label: LocalizedStringKey("button_save"), action: { if saveItem(item: item, shours: studyhours, sminutes: studyminutes, sseconds: studyseconds, bhours: breakhours, bminutes: breakminutes, bseconds: breakseconds) { isShown = false } else { triedToSave = true } /*; dismiss()*/ }, type: 0)
                    }
                }
            }
        }
    }
    
    private func saveItem(item: NewItem, shours: Int16, sminutes: Int16, sseconds: Int16, bhours: Int16, bminutes: Int16, bseconds: Int16) -> Bool {
        
        if item.subject == "" || item.whatdidyoustudy == "" {
            return false
        }
        
        let newItem = Item(context: viewContext)
        newItem.timestamp = Date()
        newItem.emotion = item.emotion
        newItem.subject = item.subject
        newItem.saynicetoyou = item.saynicetoyou
        newItem.whatdidyoustudy = item.whatdidyoustudy
        newItem.writemore = item.writemore
        newItem.studyhours = shours
        newItem.studyminutes = sminutes
        newItem.studyseconds = sseconds
        newItem.breakhours = bhours
        newItem.breakminutes = bminutes
        newItem.breakseconds = bseconds

        do {
            try viewContext.save()
            return true
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


