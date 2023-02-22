//
//  DetailView.swift
//  MC3app
//
//  Created by Aryan Garg on 22/02/23.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        GeometryReader { proxy in
            NavigationStack{
                VStack{
                    HStack{
                        Text("😇")
                        Divider()
                        VStack{
                            Text("Study Time")
                            Text("Break Time")
                        }
                    }.frame(maxWidth: 300, maxHeight: 50)
                        .cornerRadius(10.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 9)
                                .stroke(Color.black, lineWidth: 2.5)
                        )
                    Text("Subject Name")
                        .font(.system(size: 30))
                        .bold()
                    Text("Deatils")
                        .frame(maxWidth: 300, maxHeight: 150)
                            .cornerRadius(10.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(Color.black, lineWidth: 2.5)
                            )
                    Text("My Feelings")
                        .font(.system(size: 30))
                        .bold()
                    Text("Feelings")
                        .frame(maxWidth: 300, maxHeight: 150)
                            .cornerRadius(10.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(Color.black, lineWidth: 2.5)
                            )
                    Text("Kinds Words to Myself")
                        .font(.system(size: 30))
                        .bold()
                    Text("Feelings")
                        .frame(maxWidth: 300, maxHeight: 150)
                            .cornerRadius(10.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(Color.black, lineWidth: 2.5)
                            )
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
