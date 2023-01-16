//
//  File.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-06.
//

import Foundation
import UIKit
import Alamofire

class AFWrapper: NSObject {
    
    static let sharedInstance = AFWrapper()
    
    
    
    func userLogin(email:String?,password:String?,success:@escaping (UserModelResponse) -> Void, failure:@escaping (Error) -> Void){
        
        var headers: HTTPHeaders = [ ]
        
        let stringDictionary = ASP.shared.getInitialAuthParameters().mapValues { String(describing: $0) }
        
        for (key, value) in stringDictionary {
            headers.add(name: key, value: value)
        }
        
        let parms:Parameters  = [ "email": email ?? "",
                                  "password": password ?? "",
                                  "device_id": ASP.shared.deviceId,
                                  "device_token":  ""]
        
        AF.request("\(Constant.getBaseURL())/login",method: .post,parameters: parms,headers: headers)
            //.validate(statusCode: 200..<300)
            .responseData { response in // note the change to responseData
                switch response.result {
                case .failure(let error):
                    print(error)
                    failure(error)
                case .success(let data):
                    print(data)
                    
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let result = try decoder.decode(UserModelResponse.self, from: data)
                        print(result)
                         success(result)
                    } catch {
                        print(error)
                        failure(error)
                    }
                }
                    
                
            }
        
       
    }
    
    
    
    func userProfileGet(success:@escaping (UserModelResponse) -> Void, failure:@escaping (Error) -> Void){
        var headers: HTTPHeaders = [ ]
        
        let stringDictionary = ASP.shared.getInitialAuthParameters().mapValues { String(describing: $0) }
        
        for (key, value) in stringDictionary {
            headers.add(name: key, value: value)
        }
        
        
        AF.request("\(Constant.getBaseURL())/profile",method: .get,headers: headers)
          //  .validate(statusCode: 200..<300)
            .responseData { response in // note the change to responseData
                switch response.result {
                case .failure(let error):
                    print(error)
                    failure(error)
                case .success(let data):
                    print(data)
                    
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let result = try decoder.decode(UserModelResponse.self, from: data)
                        print(result)
                         success(result)
                    } catch {
                        print(error)
                        failure(error)
                    }
                }
                    
                
            }
        
    }
    
    
    
    func getUserListGet(q:String?,perPage:Int?,page:Int?,exceptoRles:String?, success:@escaping (UserListResponse) -> Void, failure:@escaping (Error) -> Void){
        var headers: HTTPHeaders = [ ]
        
        let stringDictionary = ASP.shared.getInitialAuthParameters().mapValues { String(describing: $0) }
        
        for (key, value) in stringDictionary {
            headers.add(name: key, value: value)
        }
        
        
        let parms:Parameters  = [ "q":q ?? "",
                                  "per_page":1,
                                  "except_roles": exceptoRles ?? "",
                                  "page": page ?? ""]
        
        AF.request("\(Constant.getBaseURLV2())/users",method: .get,parameters: parms,headers: headers).responseDecodable(of: UserListResponse.self) { (response) in
            switch response.result {
            case .success(let userListResponse):
                success(userListResponse)
            case .failure(let error):
                print(error)
                failure(error)
            }
        }}
        
    
}


// MARK: - UserListResponse
struct UserListResponse: Codable {
    let message: String?
    let payload: Payload?
    let status: Bool?
}

// MARK: - Payload
struct Payload: Codable {
    let currentPage: Int?
    let data: [User]?
    let from, lastPage, to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data, from
        case lastPage = "last_page"
        case to, total
    }
}
