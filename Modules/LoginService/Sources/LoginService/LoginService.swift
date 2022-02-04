import Combine

public protocol LoginService {
  //output
  var isAuthenticated: CurrentValueSubject<Bool, Never> { get }
  var token: String? { get }
  
  //input
  func login(username: String, password: String, result: (Bool) -> Void)
  func logout()
}

class DefaultLoginService: LoginService {
  
  var token: String?
  var isAuthenticated = CurrentValueSubject<Bool, Never>(false)
  
  func login(username: String, password: String, result: (Bool) -> Void) {
    isAuthenticated.send(true)
    token = "DEMO-API-KEY"
    result(true)
  }
  
  func logout() {
    isAuthenticated.send(false)
    token = nil
  }
}
