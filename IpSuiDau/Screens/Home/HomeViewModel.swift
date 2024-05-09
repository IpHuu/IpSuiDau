//
//  HomeViewModel.swift
//  IpSuiDau
//
//  Created by Ipman on 08/05/2024.
//

import Foundation
struct HomeViewModel{
    func getBanner(completion: @escaping (MBannerList?) -> Void){
        Clients.Banner.getBanners { response, error in
            if let response = response{
                completion(response)
            }
        }
    }
    func getNotificationList(firstOpen: Bool = false, completion: @escaping(MMessageList?) -> Void){
        Clients.Notification.getList(firstOpen: firstOpen) { list, error in
            if let list = list{
                completion(list)
                
            }
            if let error = error{
                print(error)
            }
        }
    }
    
    func getFavoriteList(firstOpen: Bool = false, completion: @escaping(MFavoriteList?) -> Void){
        Clients.Favorite.getFavoriteList(fistOpen: firstOpen) { response, error in
            if let list = response{
                completion(list)
            }
        }
    }
    
    func getAmount(refresh: Bool = false) async -> (Double, Double){
        
        async let usd = getTotal(type: .usd, firstOpen: !refresh)
        async let khr = getTotal(type: .khr, firstOpen: !refresh)
        return await(usd, khr)
    }
    
    func getTotal(type: AmountType, firstOpen: Bool) async -> Double{
        do{
            try await Task.sleep(nanoseconds: 1_000_000_000)
            let result = try await withThrowingTaskGroup(of: Double.self){ group -> Double in
                group.addTask{
                    await self.getSaving(type: type, firstOpen: firstOpen)
                }
                group.addTask{
                    await self.getFixedDeposited(type: type, firstOpen: firstOpen)
                }
                group.addTask{
                    await self.getDigital(type: type, firstOpen: firstOpen)
                }
                
                let allValues = try await group.reduce(0.0, +)
                return allValues
            }
            
            return result
        }catch{
            return 0
        }
        
    }
    
    func getSaving(type: AmountType, firstOpen: Bool) async -> Double{
        do{
            let response = try await Clients.Amount.saving(type: type, firstOpen: firstOpen)
            if let list = response.savingsList{
                let total = list.reduce(0.0) { partialResult, next in
                    return partialResult + next.balance
                }
                return total
            }
            return 0
        }catch (_){
            return 0
        }
    }
    
    func getFixedDeposited(type: AmountType, firstOpen: Bool) async -> Double{
        do{
            let response = try await Clients.Amount.fixedDeposited(type: type, firstOpen: firstOpen)
            if let list = response.fixedDepositList{
                let total = list.reduce(0.0) { partialResult, next in
                    return partialResult + next.balance
                }
                return total
            }
            return 0
        }catch{
            return 0
        }
    }
    
    func getDigital(type: AmountType, firstOpen: Bool) async -> Double{
        do{
            let response = try await Clients.Amount.digital(type: type, firstOpen: firstOpen)
            if let list = response.digitalList{
                let total = list.reduce(0.0) { partialResult, next in
                    return partialResult + next.balance
                }
                return total
            }
            return 0
        }catch{
            return 0
        }
    }
}
