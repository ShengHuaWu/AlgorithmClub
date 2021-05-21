import Foundation

// Request Response Snapshot Testing
//
// 1. Send any RESTful request and get the response
// 2. Record the request with the response into file
// 3. Verify the same request should have the same response

enum RestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct RestRequest {
    let url: URL
    let method: RestMethod
    let headers: [String: String]
    let body: Data?
    
    init(url: URL, method: RestMethod, headers: [String: String] = [:], body: Data? = nil) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
    }
}

extension RestRequest {
    var urlRequest: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let existingHeaders = request.allHTTPHeaderFields, !headers.isEmpty {
            // Override values from the existing headers
            request.allHTTPHeaderFields = existingHeaders.merging(headers, uniquingKeysWith: { $1 })
        }
        
        request.httpBody = body
        
        return request
    }
}

struct RestOperation<Resource> {
    let buildRequest: () -> RestRequest
    let parse: (Data) throws -> Resource
}

extension RestOperation where Resource: Decodable {
    init(_ buildRequest: @escaping () -> RestRequest) {
        self.buildRequest = buildRequest
        self.parse = { try JSONDecoder().decode(Resource.self, from: $0) }
    }
}

struct Logger<Content> {
    let record: (Content) -> Void
}

extension Logger {
    func pullback<NewContent>(_ f: @escaping (NewContent) -> Content) -> Logger<NewContent> {
        .init { newContent in
            self.record(f(newContent))
        }
    }
    
    func pullback<NewContent>(_ keypath: KeyPath<NewContent, Content>) -> Logger<NewContent> {
        pullback { $0[keyPath: keypath] }
    }
}

extension Logger where Content == String {
    static let debug = Self(
        record: { content in
            print(content)
        })
}

extension URLRequest {
    var content: String {
        let urlString = url?.absoluteString ?? ""
        let method = httpMethod ?? ""
        let headers = allHTTPHeaderFields ?? [:]
        let body = httpBody.flatMap { try? JSONSerialization.jsonObject(with: $0, options: []) }.debugDescription
        
        return """
        REST Request:
        - url: \(urlString)
        - method: \(method)
        - headers: \(headers)
        - body: \(body)
        """
    }
}

extension HTTPURLResponse {
    var content: String {
        let urlString = url?.absoluteString ?? ""
        
        return """
        REST HTTP Response:
        - url: \(urlString)
        - statusCode: \(statusCode)
        - headers: \(allHeaderFields)
        """
    }
}

extension Error {
    var restErrorContent: String {
        """
        REST Error:
        \(localizedDescription)
        """
    }
}

extension Data {
    var restResponseContent: String {
        if let json = try? JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] {
            return """
            REST Response Data:
            - json: \(json.debugDescription)
            """
        }

        if let text = String(data: self, encoding: .utf8) {
            return """
            REST Response Data:
            - utf8 string: \(text)
            """
        }
        
        return """
        REST Response Data:
        Unable to parse the response data into JSON or UTF8 string.
        The length of the data is `\(count)`.
        """
    }
}

enum RestClientError: Error {
    case networkFailure(Error)
    case invalidResponse(URLResponse?)
    case emptyData
    case parsingFailure(Error)
    case generic(message: String)
}

final class RestClient {
    private let urlSession: URLSession
    private let logger: Logger<String>
    
    init(_ urlSession: URLSession = .shared, _ logger: Logger<String> = .debug) {
        self.urlSession = urlSession
        self.logger = logger
    }
    
    func perform<Resource>(_ operation: RestOperation<Resource>, _ completion: @escaping (Result<Resource, RestClientError>) -> Void) {
        let request = operation.buildRequest().urlRequest
        logger.pullback(\.content).record(request)
        
        let task = urlSession.dataTask(with: request) { [weak self] data, response, error in
            guard let strongSelf = self else {
                completion(.failure(.generic(message: "RestClient instance has been deallocated already before the response comes back")))
                return
            }
            
            do {
                let unwrappedData = try strongSelf.sanitize(data: data, response: response, error: error)
                let resource = try operation.parse(unwrappedData)
                completion(.success(resource))
            } catch let error as RestClientError {
                completion(.failure(error))
            } catch let error {
                completion(.failure(.parsingFailure(error)))
            }
        }
        task.resume()
    }
    
    private func sanitize(data: Data?, response: URLResponse?, error: Error?) throws -> Data {
        if let unwrappedError = error {
            logger.pullback(\.restErrorContent).record(unwrappedError)
            throw RestClientError.networkFailure(unwrappedError)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
            let invalidResponseError = RestClientError.invalidResponse(response)
            logger.pullback(\.restErrorContent).record(invalidResponseError)
            throw invalidResponseError
        }
        
        logger.pullback(\.content).record(httpResponse)
        
        // It might be necessary to parse the data for error as well
        
        guard let unwrappedData = data else {
            throw RestClientError.emptyData
        }
        
        logger.pullback(\.restResponseContent).record(unwrappedData)
        
        return unwrappedData
    }
}

// TODO:
// 1. Move this file in a small project instead of playground
// 2. Consider logging with `FileManager`
// 3. Consider moving logger out of `RestClient`
// 4. Consider retieving logging content and comparison
