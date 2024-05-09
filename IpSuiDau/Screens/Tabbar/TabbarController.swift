//
//  TabbarController.swift
//  IpSuiDau
//
//  Created by Ipman on 08/05/2024.
//

import Foundation
import UIKit
final class TabBarController: UITabBarController {
    private let homeVC = HomeViewController()
    private let myPageVC = AccountViewController()
    private let tabBarView = TabBarView(frame: .zero)
    var currTab = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setLayout()
        configTabBarBtn()
    }
}

private extension TabBarController {
    func configure() {
        tabBar.isHidden = true
        viewControllers = [homeVC, myPageVC]
    }
    
    func setLayout() {
        view.addSubview(tabBarView)
        
        tabBarView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tabBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            tabBarView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24 * 2),
            tabBarView.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    func configTabBarBtn() {
        tabBarView.houseBtn.addTarget(
            self,
            action: #selector(didTappedHome),
            for: .touchUpInside)
        tabBarView.accountBtn.addTarget(
            self,
            action: #selector(didTappedMyPage),
            for: .touchUpInside)
    }
    
    @objc func didTappedHome() {
        if currTab != 0{
            selectedIndex = 0
            currTab = 0
        }
        
    }
    
    @objc func didTappedMyPage() {
        if currTab != 1{
            selectedIndex = 1
            currTab = 1
        }
        
    }
    
    @objc func didTappedBarbtn() {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
