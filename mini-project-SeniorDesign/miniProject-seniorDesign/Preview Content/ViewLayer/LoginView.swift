//
//  LoginView.swift
//  miniProject-seniorDesign
//
//  Created by Darien Aranda on 11/9/24.
//
import SwiftUI

struct LoginView: View {
    @Binding var loginState: LoginState
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isSecure: Bool = false
    
    var body: some View {
        VStack{
            //Title Heading
            Text("This is the Login View!")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 40)
            
            HStack {
                //Username Text Field
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
            }
            .padding()
            
            HStack{
                //Password Field
                if isSecure{
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 20)
                }else{
                    TextField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }
            }
            .padding()
            
            //Attempting to Toggle Show/Hide password to test button func
            Button(action: {
                isSecure.toggle()
            }) {
                Text(isSecure ? "Show Password:" : "Hide Password")
                    .foregroundColor(.blue)
            }
            .padding(.bottom, 20)
            
            //Login Button
            Button(action: {
                login()
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
    
    func login(){
        //Actions for the button added here
        print("Username: \(username), Password: \(password)" )
    }
}
