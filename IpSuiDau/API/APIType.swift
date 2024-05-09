//
//  APIType.swift
//  IpSuiDau
//
//  Created by Ipman on 08/05/2024.
//

import Foundation
enum AmountType{
    case usd
    case khr
}
enum APIType{
    case emptyNotificationList
    case notificationList
    case saving(type: AmountType, fisrtOpen: Bool)
    case fixedDeposited(type: AmountType, fisrtOpen: Bool)
    case digital(type: AmountType, fisrtOpen: Bool)
    case favoriteList(firstOpen: Bool)
    case bannerList
    var url: String{
        switch self {
        case .emptyNotificationList:
            return APIConstants.notification.empty
        case .notificationList:
            return APIConstants.notification.notEmpty
        case .saving(let type, let value):
            switch type {
            case .usd:
                return value ? APIConstants.amount.usd.saving : APIConstants.amountRefresh.usd.saving
            case .khr:
                return value ? APIConstants.amount.khr.saving : APIConstants.amountRefresh.khr.saving
            }
        case .fixedDeposited(let type, let value):
            switch type {
            case .usd:
                return value ? APIConstants.amount.usd.fixed : APIConstants.amountRefresh.usd.fixed
            case .khr:
                return value ? APIConstants.amount.khr.fixed : APIConstants.amountRefresh.khr.fixed
            }
        case .digital(let type, let value):
            switch type {
            case .usd:
                return value ? APIConstants.amount.usd.digital : APIConstants.amountRefresh.usd.digital
            case .khr:
                return value ? APIConstants.amount.khr.digital : APIConstants.amountRefresh.khr.digital
            }
        case .favoriteList(let value):
            return value ? APIConstants.favorite.empty : APIConstants.favorite.notEmpty
        case .bannerList:
            return APIConstants.banner.adbanner
        }
    }
}
