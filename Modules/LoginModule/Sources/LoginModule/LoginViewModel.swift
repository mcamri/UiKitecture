//
//  LoginViewModel.swift
//  UiKitecture
//
//  Created by amri.mc on 17/1/22.
//

import Foundation
import LoginService
import Combine

class LoginViewModel {
  
  var username = CurrentValueSubject<String, Never>("")
  var password = CurrentValueSubject<String, Never>("")
  
  var loginService: LoginService
  var loginModule: LoginModule?
  
  init(loginService: LoginService) {
    self.loginService = loginService
  }
  
  func login() {
    loginService.login(username: username.value, password: password.value, result: { _ in })
  }
}
