//
//  File.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-06.
//

import Foundation
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
            .validate(statusCode: 200..<300)
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
    
    
    
}
// MARK: - UserModelResponse
struct UserModelResponse: Codable {
    let message: String?
    let payload: User?
}

// MARK: - Payload
struct User: Codable {
    var id: Int?
    var name, email, twoFactorSecret, twoFactorRecoveryCodes: String?
    var dob, gender, address, createdAt: String?
    var updatedAt, phone, deviceToken, deviceID: String?
    var deletedAt, lastSeen: String?
    var isOnline: Bool?
    var roles: String?
    var avatarURL: String?
    var accessToken: String?
    
}
