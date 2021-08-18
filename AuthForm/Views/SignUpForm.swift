//
//  SignUpForm.swift
//  AuthorithationForm
//
//  Created by Dzmitry Makarevich on 8/18/21.
//

import SwiftUI

struct SignUpForm: View {
    @StateObject var viewModel: SignUpViewModel
    
    var body: some View {
        Form {
            Section(header: Text("Username")) {
                TextField("Username", text: $viewModel.username)
                    .autocapitalization(.none)
            }
            Section(header: Text("Password"),
                    footer: errorText(viewModel.inlinePasswordError)) {
                SecureField("Password", text: $viewModel.password)
                SecureField("Password again", text: $viewModel.passwordAgain)
                
            }
        }
    }

    private func errorText(_ errorString: String) -> some View {
        Text(errorString).foregroundColor(.red)
    }
}

struct SignUpForm_Previews: PreviewProvider {
    static var previews: some View {
        SignUpForm(viewModel: SignUpViewModel())
    }
}
