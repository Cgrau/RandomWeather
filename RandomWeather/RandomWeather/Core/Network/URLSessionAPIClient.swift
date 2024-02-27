import Combine
import Foundation

protocol APIClientProtocol {
   func request<T: Decodable>(_ endpoint: APIEndpoint) -> AnyPublisher<T, Error>
}

final class URLSessionAPIClient<EndpointType: APIEndpoint>: APIClientProtocol {
   let session: URLSessionProtocol
   
   init(session: URLSessionProtocol) {
      self.session = session
   }
   
   static func buildDefault() -> Self {
      .init(session: URLSession.shared)
   }
   
   func request<T: Decodable>(_ endpoint: APIEndpoint) -> AnyPublisher<T, Error> {
      let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
      var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
      components?.queryItems = endpoint.parameters?.map { key, value in
         URLQueryItem(name: key, value: String(describing: value))
      }
      var request = URLRequest(url: components?.url ?? url)
      request.httpMethod = endpoint.method.rawValue
      
      endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
      
      return session.dataTaskPublisher(for: request)
         .subscribe(on: DispatchQueue.global(qos: .background))
         .tryMap { data, response -> Data in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
               throw APIError.invalidResponse
            }
            return data
         }
         .tryMap { data -> T in
            do {
               return try JSONDecoder().decode(T.self, from: data)
            } catch {
               throw APIError.jsonDecodingError(error: error)
            }
         }
         .eraseToAnyPublisher()
   }
}

