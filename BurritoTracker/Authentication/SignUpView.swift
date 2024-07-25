//
//  SignUpView.swift
//  BurritoTracker
//
//  Created by Matt Ginelli on 7/25/24.
//

import SwiftUI

struct SignUpView: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmedPassword = ""
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack {
            
            // Logo
            
            HStack {
                Text("🌯")
                    .font(.system(size: 64))
                Text("Bets")
                    .font(.system(size: 48))
                    .fontWeight(.semibold)
            }
            .padding(.vertical, 32)
            
            
            // Full Name
            VStack {
                InputField(text: $fullName, 
                           title: "Full Name",
                           placeholder: "John Doe")
                
                
                // email address
                
                InputField(text: $email,
                           title: "Email Address",
                           placeholder: "name@example.com")
                            .autocapitalization(.none)
                
                // password
                
                InputField(text: $password, 
                           title: "Passord", 
                           placeholder: "",
                           isSecureField: true)
                
                // confirm password
                
                InputField(text: $confirmedPassword, 
                           title: "Confirm Password",
                           placeholder: "",
                           isSecureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            // button
            Button(action: {
                signUp(fullName: fullName, 
                       email: email,
                       password: password,
                       confirmedPassword: confirmedPassword)
            }) {
                Text("Sign up")
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 24)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 24)
            .padding(.bottom, 12)
            // sign in if already have an account
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                    Text("Sign in")
                        .fontWeight(.semibold)
                }
            }
        }
    }
    
    func signUp(fullName: String, email: String, password: String, confirmedPassword: String) {
        if password == confirmedPassword {
            print("Successfully signed in")
        } else {
            print("Password not confirmed!")
        }
    }
    
}

#Preview {
    SignUpView()
}
