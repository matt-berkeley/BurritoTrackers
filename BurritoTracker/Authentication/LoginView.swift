//
//  LoginView.swift
//  BurritoTracker
//
//  Created by Matt Ginelli on 7/24/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("🌯")
                        .font(.system(size: 64))
                    Text("Bets")
                        .font(.system(size: 48))
                        .fontWeight(.semibold)
                }
                .padding(.vertical, 32)
                
                
                VStack {
                    // email field
                    InputField(text: $email, title: "Email Address", placeholder: "name@example.com")
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    
                    // password field
                    
                    InputField(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                Button(action: {
                    login(email: email, password: password)
                }) {
                    Text("Sign In")
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 24)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 24)
                .padding(.bottom, 12)

                
                Spacer()
                
                NavigationLink(destination: {
                    // more to come here
                    SignUpView()
                        .navigationBarBackButtonHidden(true)
                }) {
                    HStack {
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                }
            }
            
        }
        
    }
    
    func login(email: String, password: String) {
        print("Successful login of \(email) with password \(password)")
    }
    
}

#Preview {
    LoginView()
}
