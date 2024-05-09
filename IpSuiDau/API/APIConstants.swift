//
//  APIConstants.swift
//  IpSuiDau
//
//  Created by Ipman on 08/05/2024.
//

import Foundation
struct APIConstants{
    static let baseURL: String = "https://willywu0201.github.io"
    struct banner{
        static let adbanner = baseURL + "/data/banner.json"
    }
    struct notification{
        static let empty = baseURL + "/data/emptyNotificationList.json"
        static let notEmpty = baseURL + "/data/notificationList.json"
    }
    
    struct amount{
        struct usd{
            static let saving = baseURL + "/data/usdSavings1.json"
            static let fixed = baseURL + "/data/usdFixed1.json"
            static let digital = baseURL + "/data/usdDigital1.json"
        }
        struct khr{
            static let saving = baseURL + "/data/khrSavings1.json"
            static let fixed = baseURL + "/data/khrFixed1.json"
            static let digital = baseURL + "/data/khrDigital1.json"
        }
    }
    
    struct amountRefresh{
        struct usd{
            static let saving = baseURL + "/data/usdSavings2.json"
            static let fixed = baseURL + "/data/usdFixed2.json"
            static let digital = baseURL + "/data/usdDigital2.json"
        }
        struct khr{
            static let saving = baseURL + "/data/khrSavings2.json"
            static let fixed = baseURL + "/data/khrFixed2.json"
            static let digital = baseURL + "/data/khrDigital2.json"
        }
    }
    
    struct favorite{
        static let empty = baseURL + "/data/emptyFavoriteList.json"
        static let notEmpty = baseURL + "/data/favoriteList.json"
    }
}
