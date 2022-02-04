import CatService
import UIKit

class CatDetailBuilder {
  static func build(cat: Cat) -> (CatDetailModule, UIViewController) {
    let viewModel = CatDetailViewModel(cat: cat)
    let view = CatDetailViewController(viewModel: viewModel)
    let module = CatDetailModule(catDetailVC: view)
    
    viewModel.catDetailModule = module
    return (module, view)
  }
}
