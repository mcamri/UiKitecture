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

class CatDetailViewController: UIViewController {
  var viewModel: CatDetailViewModel
  
  let disposeBag = DisposeBag()
  
  private var imageView: UIImageView!
  
  init(viewModel: CatDetailViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    configureAutolayout()
    loadImage()
  }
  
  private func configureView() {
    view.backgroundColor = .white
    navigationItem.title = viewModel.cat.name
    
    imageView = UIImageView(frame: .zero)
    imageView.contentMode = .scaleAspectFit
    view.addSubview(imageView)
  }
  
  private func configureAutolayout() {
    imageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func loadImage() {
    guard let urlString = viewModel.cat.image?.url, let url = URL(string: urlString) else { return }
    
    DispatchQueue.global().async { [weak self] in
      guard let data = try? Data(contentsOf: url) else { return }
      DispatchQueue.main.async {
        self?.imageView.image = UIImage(data: data)
      }
    }
  }
}
