//
//  File.swift
//  
//
//  Created by amri.mc on 4/2/22.
//

import UIKit

class CatDetailModule {

  private weak var catDetailVC: CatDetailViewController!
  
  var view: UIViewController { catDetailVC }
  
  weak var moduleOutput: CatListModuleOutput?
  
  init(catDetailVC: CatDetailViewController) {
    self.catDetailVC = catDetailVC
  }
}
