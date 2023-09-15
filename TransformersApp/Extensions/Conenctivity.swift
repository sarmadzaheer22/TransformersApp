//
//  Conenctivity.swift
//  MoviePreview
//
//  Created by Osama Arshad on 25/08/2023.
//

import Foundation
import Alamofire


struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}


//
//
//if Connectivity.isConnectedToInternet {
//     print("Connected")
// } else {
//     print("No Internet")
//}
