//
//  NetworkManagerStub.swift
//  WeatherAppTests
//
//  Created by Mustafa.saify on 07/09/2021.
//

import Foundation
@testable import WeatherApp

class NetworkStub: NetworkContractor {
    
    private var mockFile: String

    init(withMockFile mockFile: String) {
        self.mockFile = mockFile
    }
    
    func sendRequest<T>(request: NetworkRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {

        let bundle = Bundle(for: NetworkStub.self)
        
        guard let filePath = bundle.path(forResource: mockFile, ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
              let result = try? JSONDecoder().decode(T.self, from: data) else {
            return
        }
        completion(.success(result))
    }
}
