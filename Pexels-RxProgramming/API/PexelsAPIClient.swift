//
//  PexelsAPIClient.swift
//  Pexels-RxProgramming
//
//  Created by TaishiKusunose on 2021/10/30.
//

import Foundation
import Combine

protocol PexelsAPIClientProtocol {
    func searchPictures(for text: String) -> AnyPublisher<PexelsAPIResponce, Error>
}

class PexelsAPIClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension PexelsAPIClient: PexelsAPIClientProtocol {
    func searchPictures(for text: String) -> AnyPublisher<PexelsAPIResponce, Error> {
        return loadPicture(with: searchAPIComponents(with: text))
    }
    
    func loadPicture(with components: URLComponents) -> AnyPublisher<PexelsAPIResponce, Error> {
        guard let url = components.url else {
            let error = APIError.message("networkError")
            return Fail(error: error).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.addValue(PexelsAPIKey.text, forHTTPHeaderField: "authorization")
        print(request)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: PexelsAPIResponce.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

// MARK: - PexelsAPIClient API
private extension PexelsAPIClient {
    struct PexelsAPI {
        static let scheme = "https"
        static let host = "api.pexels.com"
        static let path = "/v1"
    }
    
    struct OpenWeatherAPI {
        static let scheme = "https"
        static let host = "api.openweathermap.org"
        static let path = "/data/2.5"
        static let key = "d7193aff3238fb90b6718bcd8e52456d"
    }
    
    func searchAPIComponents(
        with text: String
    ) -> URLComponents {
        var components = URLComponents()
        components.scheme = PexelsAPI.scheme
        components.host = PexelsAPI.host
        components.path = PexelsAPI.path + "/search"
        
        components.queryItems = [
            URLQueryItem(name: "query", value: text),
        ]
        
        
        return components
    }
}

enum APIError: Error {
    case data(Data, Int?)
    case decodeError(Data)
    case message(String)
    case invalidResponse
    case unknown(Error)
}
