//
//  LoginView.swift
//  miniProject-seniorDesign
//
//  Created by Darien Aranda on 11/9/24.
//
import SwiftUI

struct LoginView: View {
    @Binding var loginState: LoginState
    
    var body: some View {
        VStack{
            Text("This is the Login View!")
            Button(action:({
                print("Test that button works")
            })
                   label: Text("Change to User View Here")
                .padding()
                .background(Color.green)
                .foregroundColor(.tan)
                   
        }
    }
}

