//
//  LoginServiceBuilder.swift
//  
//
//  Created by amri.mc on 4/2/22.
//

import Foundation

public class LoginServiceBuilder {
  public static func build() -> LoginService {
    DefaultLoginService()
  }
}
