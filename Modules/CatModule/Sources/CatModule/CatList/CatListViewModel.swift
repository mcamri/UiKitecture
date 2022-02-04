//
//  AnimalListViewModel.swift
//  Amritecture
//
//  Created by amri.mc on 15/1/22.
//

import Foundation
//import AnimalService
import Combine
import CatService

class CatListViewModel: ObservableObject {
  
  var state = CurrentValueSubject<State, Never>(.loading)
  var selectedCat = CurrentValueSubject<Cat?, Never>(nil)
  
  enum State {
    case loading
    case loaded([Cat])
    case empty(String)
    case error(String)
  }
  
  private var cancellables = Set<AnyCancellable>()
  private var catService: CatService
  var catListModule: CatListModule?
  
  init(catService: CatService) {
    self.catService = catService
    subscribeSelectedCar()
  }
  
  func loadAnimal() async {
    let result = await catService.getCatList()
    switch result {
    case .success(let cats):
      await updateState(cats.count > 0 ? .loaded(cats) : .empty("Animal list is empty!"))
    case .failure:
      await updateState(.error("Error fetching animals!"))
    }
  }
  
  @MainActor func updateState(_ state: State) async {
    self.state.send(state)
  }
  
  private func subscribeSelectedCar() {
    selectedCat.sink(receiveValue: { [weak self] cat in
      guard let cat = cat else { return }

      self?.catListModule?.select(cat: cat)
    }).store(in: &cancellables)
  }
}
