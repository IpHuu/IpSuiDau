//
//  TabbarView.swift
//  IpSuiDau
//
//  Created by Ipman on 08/05/2024.
//

import UIKit
final class TabBarView: UIView {
    lazy var houseBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icTabbarHomeActive"), for: .normal)
        button.setTitle("Home", for: .normal)
        button.setTitleColor(UIColor.orange01, for: .normal)
        button.titleLabel?.font = .textStyle8
        button.centerImageAndButton(3, imageOnTop: true)
        return button
    }()
    
    lazy var accountBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icTabbarAccountDefault"), for: .normal)
        button.setTitle("Account", for: .normal)
        button.setTitleColor(UIColor.cubeColorSystemGray7, for: .normal)
        button.titleLabel?.font = .textStyle7
        button.centerImageAndButton(3, imageOnTop: true)
        return button
    }()
    lazy var locationBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icTabbarLocationActive"), for: .normal)
        button.setTitle("Location", for: .normal)
        button.setTitleColor(UIColor.cubeColorSystemGray7, for: .normal)
        button.titleLabel?.font = .textStyle7
        button.centerImageAndButton(3, imageOnTop: true)
        return button
    }()
    lazy var serviceBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icTabbarLocationActive"), for: .normal)
        button.setTitle("Service", for: .normal)
        button.setTitleColor(UIColor.cubeColorSystemGray7, for: .normal)
        button.titleLabel?.font = .textStyle7
        button.centerImageAndButton(3, imageOnTop: true)
        return button
    }()
    
    private lazy var buttnoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 30
        
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.shadowOffset = CGSize(width: 0, height: 2)
        stack.layer.shadowOpacity = 0.1
        stack.layer.shadowRadius = 10
        
        [houseBtn, accountBtn, locationBtn, serviceBtn].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(buttnoStackView)
        
        buttnoStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttnoStackView.topAnchor.constraint(equalTo: self.topAnchor),
            buttnoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttnoStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            buttnoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
