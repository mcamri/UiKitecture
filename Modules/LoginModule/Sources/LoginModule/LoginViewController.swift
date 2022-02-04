//
//  LoginViewController.swift
//  
//
//  Created by amri.mc on 30/1/22.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
  private enum Constants {
    static let textFieldInset = 30
    static let textFieldSpace = 20
  }
  
  private var usernameTxt: UITextField!
  private var passwordTxt: UITextField!
  private var loginButton: UIButton!
  
  private var disposeBag = DisposeBag()
  
  private var viewModel: LoginViewModel
  
  init(viewModel: LoginViewModel) {
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
    configureAction()
  }
  
  private func configureView() {
    view.backgroundColor = .white
    
    usernameTxt = UITextField(frame: .zero)
    usernameTxt.borderStyle = .roundedRect
    usernameTxt.placeholder = "Username"
    usernameTxt.autocapitalizationType = .none
    usernameTxt.autocorrectionType = .no
    
    passwordTxt = UITextField(frame: .zero)
    passwordTxt.isSecureTextEntry = true
    passwordTxt.borderStyle = .roundedRect
    passwordTxt.placeholder = "Password"
    passwordTxt.autocapitalizationType = .none
    usernameTxt.autocorrectionType = .no
    
    loginButton = UIButton(type: .system)
    loginButton.setTitle("Login", for: .normal)
    loginButton.overrideUserInterfaceStyle = .dark
    
    view.addSubview(usernameTxt)
    view.addSubview(passwordTxt)
    view.addSubview(loginButton)
  }
  
  private func configureAutolayout() {
    passwordTxt.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.left.right.equalToSuperview().inset(Constants.textFieldInset)
    }
    
    usernameTxt.snp.makeConstraints { make in
      make.bottom.equalTo(passwordTxt.snp.top).offset(-Constants.textFieldSpace)
      make.left.right.equalToSuperview().inset(Constants.textFieldInset)
    }
    
    loginButton.snp.makeConstraints { make in
      make.top.equalTo(passwordTxt.snp.bottom).offset(Constants.textFieldSpace)
      make.left.right.equalToSuperview().inset(Constants.textFieldInset)
    }
  }
  
  private func configureAction() {
    loginButton.rx.tap
      .subscribe(onNext: { [weak self] _ in
        self?.viewModel.login()
      })
      .disposed(by: disposeBag)
    
    usernameTxt.rx.text
      .asObservable()
      .subscribe(onNext: { [weak self] text in
        guard let text = text else { return }
        self?.viewModel.username.send(text)
      })
      .disposed(by: disposeBag)
    
    passwordTxt.rx.text
      .asObservable()
      .subscribe(onNext: { [weak self] text in
        guard let text = text else { return }
        self?.viewModel.password.send(text)
      })
      .disposed(by: disposeBag)
  }
  
  @objc private func loginButtonPressed() {
    viewModel.login()
  }
}
