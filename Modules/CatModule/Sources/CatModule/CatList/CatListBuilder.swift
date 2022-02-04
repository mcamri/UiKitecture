import CatService
import UIKit

class CatListBuilder {
  static func build(catService: CatService) -> (CatListModule, UIViewController) {
    let viewModel = CatListViewModel(catService: catService)
    let view = CatListViewController(viewModel: viewModel)
    let module = DefaultCatListModule(catListVC: view)
    
    viewModel.catListModule = module
    return (module, view)
  }
}
