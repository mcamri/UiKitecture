//
//  LoginModule.swift
//  Uikitecture
//
//  Created by amri.mc on 17/1/22.
//

import Foundation
import LoginService
import BaseModule
import UIKit

public class LoginModule: ModuleItem {
  
  private weak var loginVC: LoginViewController?
  
  public var view: UIViewController { loginVC! }
  
  init(loginVC: LoginViewController) {
    self.loginVC = loginVC
  }
  
  deinit {
    print("login module destryed")
  }
}
