//
//  PexelsError.swift
//  Pexels-RxProgramming
//
//  Created by TaishiKusunose on 2021/10/30.
//

import Foundation

enum PexelsError: Error {
  case parsing(description: String)
  case network(description: String)
}
