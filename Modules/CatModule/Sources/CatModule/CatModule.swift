
import SwiftUI
import CatService
import BaseModule

public class CatModule: ModuleItem, CatListModuleOutput {

  private weak var catListVC: UIViewController!
  
  public var view: UIViewController { catListVC }
  
  public init(catListVC: UIViewController) {
    self.catListVC = catListVC
  }
  
  func select(cat: Cat) {
    showCatDetail(cat: cat)
  }
  
  private func showCatDetail(cat: Cat) {
    guard let uiNavigator = catListVC.navigationController else { return }
    let (_, vc) = CatDetailBuilder.build(cat: cat)
    uiNavigator.pushViewController(vc, animated: true)
  }
}

