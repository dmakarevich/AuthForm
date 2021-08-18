//
//  SignUpView.swift
//  AuthorithationForm
//
//  Created by Dzmitry Makarevich on 8/18/21.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject private var viewModel: SignUpViewModel
    
    var body: some View {
        VStack {
            SignUpForm(viewModel: viewModel)
            
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
            
        }
        .navigationTitle("Sign up")
    }
    
    private func errorText(_ errorString: String) -> some View {
        Text(errorString).foregroundColor(.red)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(SignUpViewModel())
    }
}
