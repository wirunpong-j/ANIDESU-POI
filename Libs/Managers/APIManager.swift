//
//  APIManager.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 17/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    public static let manager: Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [:]
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        return Alamofire.SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }()
    
    public static func request<Result: Decodable>(withRouter router: Router, responseType: Result.Type, completion: @escaping (_ result: Result) -> (), onFailure: @escaping (_ error: Error) -> ()) -> Request? {
        
        return manager.request(router).responseData(completionHandler: { (response) in
            switch response.result {
            case .success(let data):
                let responseObj = try! JSONDecoder().decode(responseType, from: data)
                completion(responseObj)
                
            case .failure(let error):
                onFailure(error)
            }
        })
    }
}
