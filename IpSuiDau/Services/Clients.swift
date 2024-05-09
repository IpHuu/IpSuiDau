//
//  Clients.swift
//  IpSuiDau
//
//  Created by Ipman on 08/05/2024.
//

import Foundation
class Clients: NSObject{
    static let shared = Clients()
    struct Notification{
        static func getList(firstOpen: Bool = true, completion: @escaping (MMessageList?, APIError?) -> Void){
            Network<MMessageList>.request(api: firstOpen ? .emptyNotificationList : .notificationList) { response, error in
                if let response = response{
                    completion(response.result, nil)
                }
                
                if let error = error{
                    completion(nil, error)
                }
            }
        }
    }
    
    struct Amount{
        static func saving(type: AmountType, firstOpen: Bool = true) async throws -> MSavingList{
            try await withCheckedThrowingContinuation({ c in
                Network<MSavingList>.request(api: .saving(type: type, fisrtOpen: firstOpen)) { response, error in
                    if let response = response{
                        c.resume(returning: response.result)
                    }
                    
                    if let error = error{
                        c.resume(throwing: error)
                    }
                }
            })
            
        }
        
        static func fixedDeposited(type: AmountType, firstOpen: Bool = true) async throws -> MFixedDepositList{
            try await withCheckedThrowingContinuation({ c in
                Network<MFixedDepositList>.request(api: .fixedDeposited(type: type, fisrtOpen: firstOpen)) { response, error in
                    if let response = response{
                        c.resume(returning: response.result)
                    }
                    
                    if let error = error{
                        c.resume(throwing: error)
                    }
                }
            })
            
        }
        
        static func digital(type: AmountType, firstOpen: Bool = true) async throws -> MDigitalList{
            try await withCheckedThrowingContinuation({ c in
                Network<MDigitalList>.request(api: .digital(type: type, fisrtOpen: firstOpen)) { response, error in
                    if let response = response{
                        c.resume(returning: response.result)
                    }
                    
                    if let error = error{
                        c.resume(throwing: error)
                    }
                }
            })
            
        }
    }
    
    struct Favorite {
        static func getFavoriteList(fistOpen: Bool = true, completion: @escaping(MFavoriteList?, APIError?) -> Void){
            Network<MFavoriteList>.request(api: .favoriteList(firstOpen: fistOpen)) { response, error in
                if let response = response{
                    completion(response.result, nil)
                }
                
                if let error = error{
                    completion(nil, error)
                }
            }
        }
    }
    
    struct Banner{
        static func getBanners(completion: @escaping(MBannerList?, APIError?) -> Void){
            Network<MBannerList>.request(api: .bannerList) { response, error in
                if let response = response{
                    completion(response.result, nil)
                }
                
                if let error = error{
                    completion(nil, error)
                }
            }
        }
    }
}

