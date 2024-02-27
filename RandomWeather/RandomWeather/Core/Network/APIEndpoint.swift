import Foundation

protocol APIEndpoint {
   var baseURL: URL { get }
   var path: String { get }
   var method: HTTPMethod { get }
   var headers: [String: String]? { get }
   var parameters: [String: Any]? { get }
}

extension APIEndpoint {
   var headers: [String: String]? {
      return nil
   }
   
   var parameters: [String: Any]? {
      return nil
   }
}


enum APIError: Error {
   case unexpectedError
   case invalidRequest
   case invalidResponse
   case dataLoadingError(statusCode: Int, data: Data)
   case jsonDecodingError(error: Error)
}

enum HTTPMethod: String {
   case get = "GET"
   case post = "POST"
   case put = "PUT"
   case patch = "PATCH"
   case delete = "DELETE"
}
