//
//  NetworkManager.swift
//  Gojek
//
//  Created by Neeraj Solanki on 27/09/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

class HTTPClient {
    // MARK: Typealias
    typealias CompletionResult = (Result<Data?, GJError>) -> Void
    
    // MARK: - Shared Instance
    static let shared = HTTPClient(session: URLSession.shared)
    
    // MARK: - Private Properties
    private let session: URLSessionProtocol
    private var task: URLSessionDataTaskProtocol?
    private var completionResult: CompletionResult?

    // MARK: - Initialiser
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    // MARK: - Data Task Helper
    func dataTask(_ request: RequestProtocol, completion: @escaping CompletionResult) {
        completionResult = completion
        var urlRequest = URLRequest(url: request.baseURL.appendingPathComponent(request.path),
                                    cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                    timeoutInterval: Constants.Service.timeout)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.httpBody = request.httpBody
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        task = session.dataTask(with: urlRequest) { (data, response, error) in
            //return error if there is any error in making request
            if let error = error {
                self.completionResult(.failure(GJError(error.localizedDescription)))
                return
            }
            
            //check response
            if let response = response, response.isSuccess {
                if let data = data {
                    self.completionResult(.success(data))
                }
                
                if response.httpStatusCode == 204 {
                    self.completionResult(.success(nil))
                }
            } else {
                let commonErrorMessage = NSLocalizedString("Somthing went wrong!", comment: "")
                guard let data = data else {
                    self.completionResult(.failure(GJError(commonErrorMessage)))
                    return
                }
                do {
                    let serverError = try JSONDecoder().decode(ServerError.self, from: data)
                    self.completionResult(.failure(GJError(serverError.error ?? commonErrorMessage)))
                } catch {
                    self.completionResult(.failure(GJError(commonErrorMessage)))
                }
            }
        }
        
        //Resume task
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    // MARK: - Private Helper Function
    private func completionResult(_ result: Result<Data?, GJError>) {
        DispatchQueue.main.async {
            self.completionResult?(result)
        }
    }
}
