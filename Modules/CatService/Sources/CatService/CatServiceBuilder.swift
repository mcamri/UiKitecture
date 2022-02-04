//
//  CatServiceBuilder.swift
//  
//
//  Created by amri.mc on 4/2/22.
//

import Foundation
import LoginService

public class CatServiceBuilder {
  public static func build(loginService: LoginService) -> CatService {
    CatAnimalService(loginService: loginService)
  }
}
