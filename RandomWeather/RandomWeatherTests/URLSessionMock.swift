import Combine
import Foundation
@testable import RandomWeather

protocol MockURLSessionProtocol: URLSessionProtocol {
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
}

class MockURLSession: MockURLSessionProtocol, URLSessionProtocol {
    let data: Data
    let response: URLResponse
    let error: Error?

    init(data: Data, response: URLResponse, error: Error? = nil) {
        self.data = data
        self.response = response
        self.error = error
    }

    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher {
        let publisher = Result {
            if let error = self.error {
                throw error
            }
            return (data: self.data, response: self.response)
        }
        .publisher
        .mapError { $0 as! URLError }
       
       let customSession = CustomURLSession()
       return customSession.dataTaskPublisher(for: request)
    }
}

class CustomURLSession: URLSessionProtocol {
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: request)
    }
}
