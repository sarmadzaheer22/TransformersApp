//
//  APIManager.swift
//  TransformersApp
//
//  Created by capregsoft on 14/09/2023.
//
import Foundation
import Alamofire
import zlib

class APIManager {
    
//    func popularMovies(parameters: [String:String],
//                        completionHandler: @escaping (MoviesList?,Error?) -> Void) -> Void {
//
//        print(parameters)
//
//        var headers:[String: String] = [
//          "accept": "application/json",
//          "Authorization": "Bearer \(Constants.apiAuthorization)"
//        ]
//
//        let httpHeaders = HTTPHeaders(headers)
//
//        //headers.merge(parameters) { (_, new) in new }
//
//        let url = URL(string: Constants.popularMoviesUrl)!
//        AF.request(url,method: .get,parameters:parameters, headers: httpHeaders).response { response in
//            dump(response)
//            if let data = response.data{
//                let movieList = try? JSONDecoder().decode(MoviesList.self, from: data)
//                    completionHandler(movieList,nil)
//
//            }else{
//                completionHandler(nil,response.error)
//            }
//           }
//
//    }
    
    func tempGet(){
        
        let token = getToken(){
            token in
            
            //perfom Query
            print("I m here")
        }
        
    }
    
    
//    func movieDetails(movieId: String,
//                        completionHandler: @escaping (MovieDetails?,Error?) -> Void) -> Void {
//
//        var headers:[String: String] = [
//          "accept": "application/json",
//          "Authorization": "Bearer \(Constants.apiAuthorization)"
//        ]
//
//        let httpHeaders = HTTPHeaders(headers)
//
//
//
//        let url = URL(string: "\(Constants.movieDetailsUrl)\(movieId)")!
//
//        AF.request(url,method: .get,headers: httpHeaders).response { response in
//            if let data = response.data{
//                let movieList = try? JSONDecoder().decode(MovieDetails.self, from: data)
//                    completionHandler(movieList,nil)
//            }else{
//                completionHandler(nil,response.error)
//            }
//           }
//    }
    
    
    private func getToken(completionHandler: @escaping (Bool) -> Void) -> Void {
        
        if let token = UserDefaults.standard.value(forKey: "token") as? String{
            completionHandler(true)
        }else{
            let url = URL(string: Constants.tokenUrl)!
            AF.request(url,method: .get).response { response in
               // dump(response)
                if let data = response.data{
                    dump(data)
                        completionHandler(true)
                        
                }else{
                    completionHandler(false)
                }
               }
            
        }
    }

}

