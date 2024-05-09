//
//  MessageItem.swift
//  IpSuiDau
//
//  Created by Ipman on 08/05/2024.
//

import Foundation
struct MMessageItem: Decodable{
    var status: Bool = false
    var updateDateTime: String = ""
    var title: String = ""
    var message: String = ""
}
