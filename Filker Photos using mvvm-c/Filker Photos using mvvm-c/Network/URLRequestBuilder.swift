//
//  URLRequestBuilder.swift
//  mvvm-c
//
//  Created by Xapps-Mac01 on 06/08/2023.
//

import Alamofire

protocol URLRequestBuilder: URLRequestConvertible {
    var baseURL: URL { get }
    var requestURL: URL { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var urlRequest: URLRequest { get }
}

extension URLRequestBuilder {
    
    var baseURL: URL {
        return AppConstants.ServerInfo.baseURL
    }
    
    var requestURL: URL {
        return baseURL.appendingPathComponent(path, isDirectory: false)
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var headers: HTTPHeaders {
        let header = HTTPHeaders()
        return header
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        request.cachePolicy = .returnCacheDataElseLoad
        request.timeoutInterval = 10
        headers.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.name)
        }
        return request
    }
    
    public func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: parameters)
    }
}
