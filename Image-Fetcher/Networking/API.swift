//
//  API.swift
//  Image-Fetcher
//
//  Created by Hussein Anwar on 03/11/2022.
//

import Foundation
import Alamofire

enum Api: URLRequestConvertible {
    case photos(request: PhotoRequestModel)
}

extension Api: ApiRouter{
    //MARK: - URLRequestConvertible
    
    static let baseURLString = "https://jsonplaceholder.typicode.com"

    
    func asURLRequest() throws -> URLRequest {
        let url = try (Api.baseURLString + path).asURL()
        
        var urlRequest = URLRequest(url: url)
        
        //Http method
        urlRequest.httpMethod = method.rawValue

        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
//        print("🚀🚀🚀 URL:- ",urlRequest)
      print("🚀🚀🚀 URL:- ",url,Serialization(object: parameters as AnyObject))
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    private func Serialization(object: AnyObject)  -> String {
        do {
            let stringData = try JSONSerialization.data(withJSONObject: object, options: [])
            if let string = String(data: stringData, encoding: String.Encoding.utf8){
                return string
            }
        } catch _ {
            
        }
        return "{\"element\":\"jsonError\"}"
    }

    
    var method: HTTPMethod {
        switch self {
  
        case .photos:
            return .get
        }
    }
    
    var path: String {
        switch self {
        
        case .photos:
            return "/photos?"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        
        case .photos(let request):
            return request.toDictionary()
        }
    }

}
