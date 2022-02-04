
import SwiftUI
import CatService
import BaseModule

protocol CatListModuleOutput: AnyObject {
  func select(cat: Cat)
}

protocol CatListModule: ModuleItem {
  var moduleOutput: CatListModuleOutput? { get set }
  func select(cat: Cat)
}

class DefaultCatListModule: CatListModule {

  private weak var catListVC: CatListViewController?
  
  var view: UIViewController { catListVC! }
  
  weak var moduleOutput: CatListModuleOutput?
  
  init(catListVC: CatListViewController) {
    self.catListVC = catListVC
  }
  
  func select(cat: Cat) {
    moduleOutput?.select(cat: cat)
  }
}

