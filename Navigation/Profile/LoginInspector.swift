//
//  LoginInspector.swift
//  Navigation
//
//  Created by Apple Mac Air on 09.01.2023.
//

import UIKit

struct LoginInspector: LoginViewControllerDelegate {
    func check(_ login: String, _ password: String) -> Bool {
       return Checker.shared.check(login, password)
    }
}
