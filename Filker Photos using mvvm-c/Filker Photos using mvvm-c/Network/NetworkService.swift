//
//  NetworkService.swift
//  mvvm-c
//
//  Created by Xapps-Mac01 on 06/08/2023.
//

import Alamofire
import Combine

protocol NetworkServiceProtocol: AnyObject {
    func execute<T: Codable>(_ urlRequest: URLRequestBuilder, model: T.Type, completion: @escaping (Result<T, AFError>) -> Void) -> AnyCancellable
}

extension NetworkServiceProtocol {
    func execute<T: Codable>(_ urlRequest: URLRequestBuilder, model: T.Type, completion: @escaping (Result<T, AFError>) -> Void) -> AnyCancellable {
        
        let requestPublisher = AFManager.sessionManager.request(urlRequest).publishDecodable(type: T.self)
        
        let cancellable = requestPublisher
            .subscribe(on: DispatchQueue(label: "Background Queue", qos: .background))
            .receive(on: RunLoop.main)
            .sink { result in
                if let value = result.value {
                    completion(Result.success(value))
                } else if let error = result.error {
                    completion(Result.failure(error))
                }
            }
        return cancellable
    }
    
}

 class NetworkService: NetworkServiceProtocol {
    public static let `default`: NetworkServiceProtocol = {
        var service = NetworkService()
        return service
    }()
     
     
}

class AFManager{
    static let sessionManager: Session = {
      //2
      let configuration = URLSessionConfiguration.af.default
      configuration.timeoutIntervalForRequest = 10
//        configuration.waitsForConnectivity = true
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
          let userInfo = ["date": Date()]
          return CachedURLResponse(
            response: response.response,
            data: response.data,
            userInfo: userInfo,
            storagePolicy: .allowed)
        })
        
      return Session(configuration: configuration,cachedResponseHandler: responseCacher)
    }()
}
