//
//  NotificationViewController.swift
//  IpSuiDau
//
//  Created by Ipman on 09/05/2024.
//

import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet weak var _tbView: UITableView!
    @IBOutlet weak var _lbHeader: UILabel!
    @IBOutlet weak var _btnBack: UIButton!
    var lbMessage = UILabel()
    var list: [MMessageItem]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _lbHeader.text = "Notifications"
        _lbHeader.font = .textStyle
        _lbHeader.textColor = .cubeColorSystemGray10
        
        _tbView.delegate = self
        _tbView.dataSource = self
        _tbView.separatorStyle = .none
        _tbView.rowHeight = UITableView.automaticDimension
        _tbView.estimatedRowHeight = 80
        let nib = UINib(nibName: "NotificationCell", bundle: nil)
        _tbView.register(nib, forCellReuseIdentifier: "NotificationCell")
        
        _btnBack.addTarget(self, action: #selector(tappedToBack), for: .touchUpInside)
        
        lbMessage.text = "Empty"
        lbMessage.font = .textStyleHeavy
        lbMessage.textColor = .cubeColorSystemGray6
        lbMessage.textAlignment = .center
        self.view.addSubview(lbMessage)
        lbMessage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lbMessage.centerXAnchor.constraint(equalTo: self._tbView.centerXAnchor),
            lbMessage.centerYAnchor.constraint(equalTo: self._tbView.centerYAnchor),
            lbMessage.widthAnchor.constraint(equalToConstant: 150),
            lbMessage.heightAnchor.constraint(equalToConstant: 20)
        ])
        if let list = list{
            lbMessage.isHidden = list.count > 0
        } else {
            lbMessage.isHidden = true
        }
        
    }
    
    @objc func tappedToBack(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        if let item = list?[indexPath.row]{
            cell._imgDot.isHidden = item.status
            cell._title.text = item.title
            cell._date.text = item.updateDateTime
            cell._content.text = item.message
        }
        return cell
        
    }
    
    
}
