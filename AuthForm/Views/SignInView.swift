//
//  SignInView.swift
//  AuthorithationForm
//
//  Created by Dzmitry Makarevich on 8/18/21.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject private var viewModel: SignInViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                SignInForm(viewModel: viewModel)
                
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 60)
                        .overlay(
                            Text("Submit")
                                .font(.title2)
                                .foregroundColor(.white)
                        )
                }
                .padding()
                .disabled(!viewModel.isValid)
                
                NavigationLink(destination: SignUpView()
                                .environmentObject(SignUpViewModel())) {
                    Rectangle()
                        .frame(height: 60)
                        .background(Color.gray)
                        .overlay(
                            Text("Sign up")
                                .font(.title2)
                                .foregroundColor(.white)
                        )
                            
                }
                .cornerRadius(10)
                .padding([.leading, .bottom, .trailing])
                
            }
            .navigationTitle("Sign in")
        }
    }
    
    private func errorText(_ errorString: String) -> some View {
        Text(errorString).foregroundColor(.red)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(SignInViewModel())
    }
}
