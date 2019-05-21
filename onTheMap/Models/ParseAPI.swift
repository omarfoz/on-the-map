//
//  ParseAPI.swift
//  onTheMap
//
//  Created by Omar Yahya Alfawzan on 5/8/19.
//  Copyright © 2019 Omar Yahya Alfawzan. All rights reserved.
//

import Foundation

class ParseClinet {

    static let parseAppID:String = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let restApiKey:String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    
    enum EndPoints {
        static let ParseBase = "https://parse.udacity.com/parse/classes/StudentLocation"
        case studentLocation(limit:Int)
        case postStudentLocation
        var urlStrings: String {
            switch self {
            case let .studentLocation(limit):
                return "\(EndPoints.ParseBase)?limit=\(limit)"
            case .postStudentLocation:
                return "\(EndPoints.ParseBase)"
            }
        }
        var url:URL {
            return URL(string: urlStrings)!
        }
    }
    
    class func getStudnentsLocations(success: @escaping ()-> Void,errors: @escaping (Error)-> Void) {
        var request = URLRequest(url: EndPoints.studentLocation(limit: 100).url)
        request.addValue(parseAppID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(restApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    errors(error)
                }
                return
            }
            
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            do {
                
                let studentInformationResponse = try decoder.decode(StudentInformationResponse.self, from: data)
                
                OneTheMapStoreInformation.shared.arrStudentsInformation = studentInformationResponse.results
                DispatchQueue.main.async {
                    success()
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
    class func sendStudentLocation(studentInfo:StudentNewLocationRequest,success:@escaping () -> Void, errors: @escaping (Error) -> Void){
        
        var request = URLRequest(url: EndPoints.postStudentLocation.url)
        request.httpMethod = "POST"
        request.addValue(parseAppID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(restApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let body = try encoder.encode(studentInfo)
            request.httpBody = body
        }catch{
            errors(error)
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errors(error)
                }
                return
            }
            
            do {
                // just to make sure of success post location
                let _ = try JSONDecoder().decode(NewLocationResponse.self, from: data!)
                DispatchQueue.main.async {
                    success()
                }
            }catch {
                
                do {
                    let failureResponse = try JSONDecoder().decode(FailureNewLocationResponse.self, from: data!)
                    DispatchQueue.main.async {
                        errors(failureResponse)
                    }
                    
                }catch {
                    DispatchQueue.main.async {
                        errors(error)
                    }
                }
            }
        }
        task.resume()
    }
        
    }
    

    

