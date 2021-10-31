//
//  PexelsViewModel.swift
//  Pexels-RxProgramming
//
//  Created by TaishiKusunose on 2021/10/30.
//

import Foundation
import Combine

class PexelsViewModel: ObservableObject{
    @Published var dataSource: [PexelsModel] = []
    @Published var loading: Bool = false
    private let apiClient: PexelsAPIClientProtocol
    private var disposables = Set<AnyCancellable>()

    init(
        apiClient: PexelsAPIClientProtocol
    ){
        self.apiClient = apiClient
    }
    
    func fetchPictures(for text: String) {
        self.dataSource = []
        self.loading = true
        apiClient.searchPictures(for: text)
            .receive(on: DispatchQueue.main)
            .sink(
              receiveCompletion: { [weak self] result in
                  guard let self = self else { return }
                  switch result {
                  case .failure(let error):
                      self.loading = false
                      print(error)
                  case .finished:
                      break
                  }
              },
              receiveValue: { [weak self] data in
                guard let self = self else { return }
                  print("success")
                  self.dataSource = self.fetchImageData(data)
                  self.loading = false
            })
            .store(in: &disposables)
    }
    
    private func fetchImageData(_ data:PexelsAPIResponce)->[PexelsModel] {
        var models: [PexelsModel] = []
        for pict in data.photos {
            guard let imageURL = URL(string: pict.src.medium) else { continue }
            do {
                let data = try Data(contentsOf: imageURL)
                let photo = PexelsModel(id: pict.id, data: data, photographer: pict.photographer)
                models.append(photo)
            } catch {
                continue
            }
        }
        return models
    }
}
