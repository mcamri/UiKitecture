//
//  AppCoordinator.swift
//  Uikitecture
//
//  Created by amri.mc on 4/2/22.
//

import Foundation
import UIKit
import CatModule
import Combine
import LoginModule

class AppCoordinator {
  
  static let shared = AppCoordinator()
  private init() { }
  
  var window: UIWindow?
  var appModule: AppModule = AppModule.shared
  
  var catModule: CatModule?
  var loginModule: LoginModule?
  
  var storage = Set<AnyCancellable>()
  
  func activate(window: UIWindow?) {
    self.window = window
    
    appModule.loginService.isAuthenticated.sink(receiveValue: { [unowned self] isAuthenticated in
      if !isAuthenticated {
        showLogin()
      } else {
        loginModule = nil
        
        showCat()
      }
    }).store(in: &storage)
  }
  
  private func showLogin() {
    let (loginModule, view) = LoginModuleBuilder.build(loginService: appModule.loginService)
    self.loginModule = loginModule
    window?.rootViewController = view
  }
  
  private func showCat() {
    let (catModule, vc) = CatModuleBuilder.build(catService: appModule.catService)
    self.catModule = catModule
    let navigationController = UINavigationController(rootViewController: vc)
    window?.rootViewController = navigationController
  }
}
