//
//  File.swift
//  
//
//  Created by amri.mc on 4/2/22.
//

import UIKit
import CatService

public class CatModuleBuilder {
  public static func build(catService: CatService) -> (CatModule, UIViewController) {
    var (catListModule, vc) = CatListBuilder.build(catService: catService)
    let module = CatModule(catListVC: vc)
    catListModule.moduleOutput = module
    
    return (module, vc)
  }
}
