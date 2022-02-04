//
//  File.swift
//  
//
//  Created by amri.mc on 4/2/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import CatService
import Combine
import SnapKit

class CatListViewController: UIViewController, UIScrollViewDelegate {
  var viewModel: CatListViewModel
  
  let disposeBag = DisposeBag()
  let cats: BehaviorRelay<[Cat]> = BehaviorRelay(value: [])
  var cancellables = Set<AnyCancellable>()
  
  var catTableView: UITableView!
  
  init(viewModel: CatListViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    subscribeToViewModel()
    configureView()
    configureAutolayout()
  }
  
  private func configureView() {
    view.backgroundColor = .white
    navigationItem.title = "Awesome Cats"
    catTableView = UITableView(frame: .zero, style: .plain)
    view.addSubview(catTableView)
    
    setupTableView()
  }
  
  private func configureAutolayout() {
    catTableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func subscribeToViewModel() {
    viewModel.state.sink(receiveValue: { [weak self] state in
      guard let strongSelf = self else { return }
      switch state {
      case .loaded(let cats):
        strongSelf.cats.accept(cats)
      case .empty(let message):
        print("empty " + message)
        break
      case .error(let message):
        print("error " + message)
        break
      case .loading:
        Task {
          await strongSelf.viewModel.loadAnimal()
        }
      }
    }).store(in: &cancellables)
    
    cats.asObservable().subscribe(onNext: { items in
      print("item number")
      print(items.count)
    }).disposed(by: disposeBag)
  }
}

extension CatListViewController {
  func setupTableView() {
    catTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    
    catTableView.rx
      .setDelegate(self)
      .disposed(by: disposeBag)
    
    cats.asObservable()
      .bind(to: catTableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { index, element, cell in
      cell.textLabel?.text = element.name
    }.disposed(by: disposeBag)
    
    catTableView.tableFooterView = UIView()
    
    catTableView.rx.itemSelected.asObservable().subscribe(onNext: { [weak self] indexPath in
      guard let cat = self?.cats.value[indexPath.row] else { return }
      self?.viewModel.selectedCat.send(cat)
    }).disposed(by: disposeBag)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
  }
}
