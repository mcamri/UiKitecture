//
//  AppModule.swift
//  Uikitecture
//
//  Created by amri.mc on 30/1/22.
//

import Foundation
import LoginService
import LoginModule
import CatService
import CatModule
import SettingModule

class AppModule {
  
  static let shared = AppModule()
  
  let loginService: LoginService = LoginServiceBuilder.build()
  let catService: CatService
  
  init() {
    catService = CatServiceBuilder.build(loginService: loginService)
  }
}
