//
//  SignInForm.swift
//  AuthorithationForm
//
//  Created by Dzmitry Makarevich on 8/18/21.
//

import SwiftUI

struct SignInForm: View {
    @StateObject var viewModel: SignInViewModel
    
    var body: some View {
        Form {
            Section(header: Text("Username")) {
                TextField("Username", text: $viewModel.username)
                    .autocapitalization(.none)
            }
            Section(header: Text("Password"),
                    footer: errorText(viewModel.inlinePasswordError)) {
                SecureField("Password", text: $viewModel.password)
            }
        }
    }

    private func errorText(_ errorString: String) -> some View {
        Text(errorString).foregroundColor(.red)
    }
}

struct SignInForm_Previews: PreviewProvider {
    static var previews: some View {
        SignInForm(viewModel: SignInViewModel())
    }
}
