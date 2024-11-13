//
//  deletePostView.swift
//  miniProject-seniorDesign
//
//  Created by Austin Lim on 11/11/24.
//

import SwiftUI

struct deletePostView: View{
    @Environment(\.presentationMode) var presentationMode
    var body: some View{
        ZStack{
            Color.black.opacity(0.4) // Semi-transparent background to simulate a modal overlay
                .edgesIgnoringSafeArea(.all) // Extends the overlay to cover the whole screen
            
            VStack(spacing: 20) {
                Text("Are you sure you want to delete this post?")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                HStack(spacing: 40){
                    Button(action:{
                        
                    }){
                        Text("No")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding()
                            .frame(width: 100)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    Button(action:{
                        
                    }){
                        Text("Yes")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding()
                            .frame(width: 100)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                }
            }
                
                
            
        }
    }
}
#Preview {
    ContentView()
}
