//
//  UdacityAPI.swift
//  onTheMap
//
//  Created by Omar Yahya Alfawzan on 5/16/19.
//  Copyright © 2019 Omar Yahya Alfawzan. All rights reserved.
//

import Foundation
class UdacityClient{
 static var userKey = ""

    enum EndPoints {
        static let UdacityBase = "https://onthemap-api.udacity.com/v1/"
        case session
        case getUserData
        
        var urlStrings: String {
            switch self {
            case .session:
                return "\(EndPoints.UdacityBase)session"
            case .getUserData:
                return "\(EndPoints.UdacityBase)users/\(userKey)"
            }
        }
        var url:URL {
            return URL(string: urlStrings)!
        }
    }
    
    
    class func sginin(username: String, password: String, sucssess: @escaping ()-> Void,errors: @escaping (Error)-> Void){
        
        let userPersonalInformation = UserPersonalInformation(username: username, password: password)
        var request = URLRequest(url: EndPoints.session.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let loginInfo = LoginRequest(udacity: userPersonalInformation)

        // encoding a JSON body from a string, can also use a Codable struct
        
        do {
            request.httpBody = try JSONEncoder().encode(loginInfo)

        }
        catch {
            DispatchQueue.main.async {
                errors(error)
            }
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data , response , error in
            
          
            if let error = error {
                DispatchQueue.main.async {
                    errors(error)
                }
                return
            }
            
            guard let data = data else {
                return
            }
            
            let range = 5..<data.count
            let newData = data.subdata(in: range)
            let decoder = JSONDecoder()
            do {
              
                let udacityResponse = try decoder.decode(UdacityResponse.self, from: newData)
                    if (udacityResponse.account.registered) {
                        userKey = udacityResponse.account.key
                        DispatchQueue.main.async {
                            sucssess()
                        }
                    }else {
                        
                  let registerError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "You are not registered"])
                        DispatchQueue.main.async {
                        
                            errors(registerError)
                        }
                     
                }
            
            } catch {
                do {
                let loginErrorResponse = try decoder.decode(LoginErrorResponse.self, from: newData)
                    DispatchQueue.main.async {
                        errors(loginErrorResponse)
                    }
                } catch {
                
                DispatchQueue.main.async {
                    errors(error)
                }
            }
            }
           
            
        }
        task.resume()
        
        
        
    }
    
 
    class func getUserData(success: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        
        let request = URLRequest(url: EndPoints.getUserData.url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            
            guard let data = data else {
                return
            }
            let range = 5..<data.count
            let newData = data.subdata(in: range)
            
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: newData)
                
                OneTheMapStoreInformation.currentUser = user
                DispatchQueue.main.async {
                    success()
                }
            }catch {
                DispatchQueue.main.async {
                    failure(error)
                }
            }
        }
        task.resume()
    }
    
   // sucssess: @escaping () -> Void, failure: @escaping (Error) -> Void
    class func logout(sucssess: @escaping () -> Void, errors: @escaping (Error) -> Void) {
        var request = URLRequest(url: EndPoints.session.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                
                DispatchQueue.main.async {
                    if let err = error{
                        errors(err)
                    }
                }
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            do {
                let logOutResponse = try JSONDecoder().decode(LogOutResponse.self, from: newData!)
                DispatchQueue.main.async {
                    sucssess()
                }
               
            }
            catch {
                DispatchQueue.main.async {
                   
                    errors(error)
                    
                }
                
            }
        }
        task.resume()
    }
    
    
}
