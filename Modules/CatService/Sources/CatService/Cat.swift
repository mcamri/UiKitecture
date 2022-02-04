//
//  Cat.swift
//  Amritecture
//
//  Created by amri.mc on 16/1/22.
//

import Foundation

public struct Cat: Decodable {
  public struct Image: Decodable {
    public var url: String?
    
    public init(url: String) {
      self.url = url
    }
  }
  
  public var id: String
  public var origin: String
  public var name: String
  public var image: Image?
  
  public init(id: String, origin: String, name: String, image: Image) {
    self.image = image
    self.origin = origin
    self.name = name
    self.id = id
  }
}
