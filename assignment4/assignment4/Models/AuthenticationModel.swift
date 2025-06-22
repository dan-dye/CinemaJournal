//
//  AuthenticationModel.swift
//  assignment4
//
//  Created by Daniel Dye on 6/22/25.
//

import Foundation

final class AuthenticationModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
}
