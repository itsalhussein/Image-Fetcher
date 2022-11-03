//
//  ApiRouter.swift
//  Image-Fetcher
//
//  Created by Hussein Anwar on 03/11/2022.
//

import Foundation
import Alamofire

protocol ApiRouter {
    //MARK: - HttpMethod
    //This returns the HttpMethod type. It's used to determine the type if several endpoints are peresent
    var method: HTTPMethod { get }
    
    //MARK: - Path
    //The path is the part following the base url
    var path: String { get }
    
    //MARK: - Parameters
    //This is the queries part, it's optional because an endpoint can be without parameters
    var parameters: Parameters? { get }
}
