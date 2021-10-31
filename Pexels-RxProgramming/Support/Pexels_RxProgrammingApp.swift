//
//  Pexels_RxProgrammingApp.swift
//  Pexels-RxProgramming
//
//  Created by TaishiKusunose on 2021/10/28.
//

import SwiftUI

@main
struct Pexels_RxProgrammingApp: App {
    var body: some Scene {
        WindowGroup {
            SearchView(viewModel: PexelsViewModel(apiClient: PexelsAPIClient()))
        }
    }
}
