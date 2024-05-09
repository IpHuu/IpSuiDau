//
//  FavoriteType.swift
//  IpSuiDau
//
//  Created by Ipman on 09/05/2024.
//

import Foundation
import UIKit
enum FavoriteType: String{
    case CUBC = "CUBC"
    case Mobile = "Mobile"
    case PMF = "PMF"
    case CreditCard = "CreditCard"
    
    func getIcon() -> UIImage{
        var nameImage: String
        switch self {
        case .CUBC:
            nameImage = "button00ElementScrollTree"
        case .Mobile:
            nameImage = "button00ElementScrollMobile"
        case .PMF:
            nameImage = "buttonScrollBuilding"
        case .CreditCard:
            nameImage = "buttonScrollCreditCard"
        }
        
        return UIImage(named: nameImage)!
    }
}
