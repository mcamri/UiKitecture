//
//  LoginModuleBuilder.swift
//  UiKitecture
//
//  Created by amri.mc on 17/1/22.
//

import Foundation
import LoginService
import UIKit

public class LoginModuleBuilder {
  public static func build(loginService: LoginService) -> (LoginModule, UIViewController) {
    let viewModel = LoginViewModel(loginService: loginService)
    let view = LoginViewController(viewModel: viewModel)
    let module = LoginModule(loginVC: view)
    
    viewModel.loginModule = module
    return (module, view)
  }
}
