import Foundation
import LoginService

public protocol CatService {
  func getCatList() async -> Result<[Cat], Error>
}

public enum MyError: Error {
  case failedToGetAnimal
}

class CatAnimalService: CatService {
  enum Constant {
    static let urlString = "https://api.thecatapi.com/v1/breeds"
  }
  
  private var loginService: LoginService
  
  func getCatList() async -> Result<[Cat], Error> {
    guard let url = URL(string: Constant.urlString),
          let token = loginService.token else { return .failure(MyError.failedToGetAnimal) }
    
    do {
      var urlRequest = URLRequest(url: url)
      urlRequest.addValue(token, forHTTPHeaderField: "x-api-key")
      let (data, _) = try await URLSession.shared.data(for: urlRequest)
      let animals = try JSONDecoder().decode([Cat].self, from: data)
      return .success(animals)
    } catch {
      print(error.localizedDescription)
      debugPrint(error)
      return .failure(error)
    }
  }
  
  init(loginService: LoginService) {
    self.loginService = loginService
  }
}
