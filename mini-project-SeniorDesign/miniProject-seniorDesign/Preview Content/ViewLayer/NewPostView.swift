//
//  NewPostView.swift
//  miniProject-seniorDesign
//
//  Created by Jacob Fernandez on 11/10/24.
//

import SwiftUI
//
struct NewPostView: View {
    @State var postContent: String = ""
    var body: some View {
        VStack
        {
            Text("Add a new post").font(.title2)
            TextField("Enter a post", text: $postContent)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                login()
            }) {
                Text("Post")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
    func login(){
        //Actions for the button added here
        print("Post content: \(postContent)" )
    }

    
    
}
#Preview {
    ContentView()
}

