//
//  File.swift
//
//
//  Created by amri.mc on 18/1/22.
//

import Foundation
import CatService

class CatDetailViewModel {
  var cat: Cat
  var catDetailModule: CatDetailModule?
  
  init(cat: Cat) {
    self.cat = cat
  }
}

