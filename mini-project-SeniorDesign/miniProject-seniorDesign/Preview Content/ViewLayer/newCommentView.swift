//
//  newCommentView.swift
//  miniProject-seniorDesign
//
//  Created by Jacob Fernandez on 11/11/24.
//
import SwiftUI

struct newCommentView: View{
    @State var newCommentString = ""
    var body: some View{
        VStack{
            Text("Add a comment").font(.title2)
            TextField("Enter a comment", text: $newCommentString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
        }
    }
    
    
    
}
#Preview {
    ContentView()
}

