//
//  APIResponse.swift
//  IpSuiDau
//
//  Created by Ipman on 08/05/2024.
//

import Foundation
struct APIResponse<T: Decodable>: Decodable{
    var msgCode: String = ""
    var msgContent: String = ""
    var result: T
    
}
