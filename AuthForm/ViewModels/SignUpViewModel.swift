//
//  SignUpViewModel.swift
//  AuthorithationForm
//
//  Created by Dzmitry Makarevich on 8/18/21.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var passwordAgain: String = ""
    
    @Published var inlinePasswordError: String = ""

    
    @Published var isValid = false
    private static let predicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$")
    
    private var isUsernameValidPublisher: AnyPublisher<Bool, Never> {
        $username
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.count >= 3 }
            .eraseToAnyPublisher()
    }

    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordEqualPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $passwordAgain)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map { $0 == $1 }
            .eraseToAnyPublisher()
    }

    private var isPasswordStrongPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { Self.predicate.evaluate(with: $0) }
            .eraseToAnyPublisher()
    }

    private var isPasswordValidPublisher: AnyPublisher<PasswordStatus, Never> {
        Publishers.CombineLatest3(isPasswordEmptyPublisher, isPasswordStrongPublisher, isPasswordEqualPublisher)
            .map {
                if $0 { return .empty }
                if !$1 { return .notStrongEnough }
                if !$2 { return .repeatedPasswordWrong }
                
                return .valid
            }
            .eraseToAnyPublisher()
    }

    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers
            .CombineLatest(isPasswordValidPublisher, isUsernameValidPublisher)
            .map { $0 == .valid && $1 }
            .eraseToAnyPublisher()
    }
    
    init() {
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: &$isValid)
        
        isPasswordValidPublisher
            .dropFirst()
            .receive(on: RunLoop.main)
            .map { passwordStatus in
                switch passwordStatus {
                case .empty:
                    return "Password cann't be empty!"
                case .notStrongEnough:
                    return "Password should has more than 6 chars and minimum one of the special chars $@$#!%*?&"
                case .repeatedPasswordWrong:
                    return "Passwords don't match!"
                case .valid:
                    return ""
                }
            }
            .assign(to: &$inlinePasswordError)
    }
    
    private enum PasswordStatus {
        case empty, notStrongEnough, repeatedPasswordWrong, valid
    }
}
