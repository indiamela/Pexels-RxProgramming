//
//  PexelsModel.swift
//  Pexels-RxProgramming
//
//  Created by TaishiKusunose on 2021/10/30.
//

import Foundation

// MARK: - Welcome
struct PexelsModel: Codable, Identifiable {
    let id: Int
    var data: Data
    let photographer: String
}


