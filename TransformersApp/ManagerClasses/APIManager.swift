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
    func tempGet(){
        
        let token = getToken(){
            token in
            
            //perfom Query
            print("I m here")
        }
        
    }
    
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

