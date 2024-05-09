//
//  HomeViewController.swift
//  IpSuiDau
//
//  Created by Ipman on 08/05/2024.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var _scrollView: UIScrollView!
    @IBOutlet weak var _lbTitleBalance: UILabel!
    @IBOutlet weak var _lbTitleMyFavorite: UILabel!
    @IBOutlet weak var _lbTitleUSD: UILabel!
    @IBOutlet weak var _lbTitleKHR: UILabel!
    @IBOutlet weak var _lbValueUSD: UILabel!
    @IBOutlet weak var _lbValueKHR: UILabel!
    
    @IBOutlet weak var _btnBell: UIButton!
    @IBOutlet weak var _btnEye: UIButton!
    @IBOutlet weak var _btnTransfer: UIButton!
    @IBOutlet weak var _btnPayment: UIButton!
    @IBOutlet weak var _btnUtility: UIButton!
    @IBOutlet weak var _btnQRPay: UIButton!
    @IBOutlet weak var _btnMyQR: UIButton!
    @IBOutlet weak var _btnTopUp: UIButton!

    @IBOutlet weak var _favoriteViewHolder: UIView!
    @IBOutlet weak var _btnMore: UIButton!
    @IBOutlet weak var _favoriteSubTitle: UILabel!
    @IBOutlet weak var _favoriteDes: UILabel!
    
    @IBOutlet weak var _collFavorite: UICollectionView!
    @IBOutlet weak var _collBanner: UICollectionView!
    @IBOutlet weak var _pageView: UIPageControl!
    var lbAD = UILabel()
    var refreshControl: UIRefreshControl!
    var viewModel: HomeViewModel = HomeViewModel()
    var isShowBalance: Bool = false
    var usd: Double = 0
    var khr: Double = 0
    var notificationList: [MMessageItem] = []
    var bannerList: [MBannerItem] = []
    var favoriteList: [MFavoriteItem] = []
    var timer = Timer()
    var counter = 0
    
    let gradientLayerUSD = CAGradientLayer()
    let gradientLayerKHR = CAGradientLayer()
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        gradientLayerUSD.frame = _lbValueUSD.bounds
        gradientLayerUSD.cornerRadius = 10
        gradientLayerKHR.frame = _lbValueKHR.bounds
        gradientLayerKHR.cornerRadius = 10
    }
    
    func loadData(firstOpen: Bool = true){
        if !firstOpen{
            viewModel.getBanner { [weak self] response in
                guard let self = self else { return }
                if let list = response?.bannerList , list.count > 0{
                    self.bannerList = list
                    DispatchQueue.main.async {
                        self.lbAD.isHidden = list.count > 0
                        self._pageView.numberOfPages = list.count
                        self._pageView.isHidden = list.count <= 0
                        self._collBanner.reloadData()
                        self.autoChangeSlideBanner()
                    }
                    
                }
            }
        }
        
        viewModel.getFavoriteList(firstOpen: firstOpen) { [weak self] response in
            guard let self = self else { return }
            if let list = response?.favoriteList, list.count > 0{
                self.favoriteList = list
                DispatchQueue.main.async {
                    self._favoriteViewHolder.isHidden = list.count > 0
                    self._collFavorite.reloadData()
                }
                
            }
        }
        
        viewModel.getNotificationList(firstOpen: firstOpen) { [weak self] list in
            guard let self = self else { return }
            self.notificationList = list?.messages ?? []
            DispatchQueue.main.async {
                self.updateStatusBell()
            }
            
        }
        Task{
            showLoading()
            let data = await viewModel.getAmount(refresh: !firstOpen)
            hiddenLoading()
            usd = data.0
            khr = data.1
            updateDisplayBalance()
        }
    }
    
    @objc func switchImage(){
        if counter < bannerList.count{
            let index = IndexPath.init(item: counter, section: 0)
            self._collBanner.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            _pageView.currentPage = counter
            counter += 1
        }else{
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self._collBanner.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            _pageView.currentPage = counter
            counter = 1
        }
    }
    
    func updateStatusBell(){
        var name: String
        name = notificationList.count > 0 ? "iconBell02Active" : "iconBell01Nomal"
        self._btnBell.setImage(UIImage(named: name), for: .normal)
    }
    
    func autoChangeSlideBanner(){
        DispatchQueue.main.async {
            self.timer.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.switchImage), userInfo: nil, repeats: true)
        }
        
    }
    
    func initUI(){
        _lbTitleBalance.font = .textStyleHeavy
        _lbTitleBalance.textColor = .cubeColorSystemGray5
        _lbTitleMyFavorite.font = .textStyleHeavy
        _lbTitleMyFavorite.textColor = .cubeColorSystemGray5
        
        _lbTitleUSD.font = .textStyle16Regular
        _lbTitleUSD.textColor = .cubeColorSystemGray5
        _lbValueUSD.font = .textStyle24Medium
        _lbValueUSD.textColor = .cubeColorSystemGray8
        
        
        _lbTitleKHR.font = .textStyle16Regular
        _lbTitleKHR.textColor = .cubeColorSystemGray5
        _lbValueKHR.font = .textStyle24Medium
        _lbValueKHR.textColor = .cubeColorSystemGray8
        
        setupGradientLayer()
        updateIconEye()
        updateDisplayBalance()
        
        _btnBell.addTarget(self, action: #selector(tappedToBell), for: .touchUpInside)
        _btnEye.addTarget(self, action: #selector(tappedToEye), for: .touchUpInside)
        _btnTransfer.tintColor = UIColor.cubeColorSystemGray7
        _btnPayment.tintColor = UIColor.cubeColorSystemGray7
        _btnUtility.tintColor = UIColor.cubeColorSystemGray7
        _btnQRPay.tintColor = UIColor.cubeColorSystemGray7
        _btnMyQR.tintColor = UIColor.cubeColorSystemGray7
        _btnTopUp.tintColor = UIColor.cubeColorSystemGray7
        _btnMore.tintColor = UIColor.cubeColorSystemGray7
        _favoriteDes.font = .textStyle4
        _favoriteDes.textColor = UIColor.cubeColorSystemGray6
        
        _favoriteSubTitle.font = .textStyle7
        _favoriteSubTitle.textColor = UIColor.cubeColorSystemGray6
        
        _collBanner.layer.cornerRadius = 10
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        _scrollView.refreshControl = refreshControl
        
        _pageView.isHidden = true
        _pageView.currentPage = 0
        _collBanner.backgroundColor = .whiteFour
        _collBanner.delegate = self
        _collBanner.dataSource = self
        
        _collFavorite.delegate = self
        _collFavorite.dataSource = self
        
        let nib = UINib(nibName: "BannerCell", bundle: nil)
        _collBanner.register(nib, forCellWithReuseIdentifier: "BannerCell")
        
        let nibFavorite = UINib(nibName: "FavoriteCell", bundle: nil)
        _collFavorite.register(nibFavorite, forCellWithReuseIdentifier: "FavoriteCell")
        
        self.view.addSubview(lbAD)
        lbAD.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lbAD.centerXAnchor.constraint(equalTo: self._collBanner.centerXAnchor),
            lbAD.centerYAnchor.constraint(equalTo: self._collBanner.centerYAnchor),
            lbAD.widthAnchor.constraint(equalToConstant: 50),
            lbAD.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        lbAD.text = "AD"
        lbAD.textColor = .white
        lbAD.font = .textStyle12Semibold
        lbAD.layer.cornerRadius = 5
        lbAD.clipsToBounds = true
        lbAD.textAlignment = .center
        lbAD.backgroundColor = .cubeColorSystemGray4
        
    }
    
    @objc func tappedToEye(){
        isShowBalance.toggle()
        updateIconEye()
        updateDisplayBalance()
    }
    
    @objc func tappedToBell(){
        let vc = NotificationViewController()
        vc.list = notificationList
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateIconEye(){
        let imageName = isShowBalance ? "iconEye01On" : "iconEye02Off"
        let image = UIImage(named:  imageName)
        _btnEye.setImage(image, for: .normal)
    }
    
    func updateDisplayBalance(){
        _lbValueUSD.text = isShowBalance ? usd.currencyString : "*******"
        _lbValueKHR.text = isShowBalance ? khr.currencyString : "*******"
    }
    
    @objc func refresh(){
        loadData(firstOpen: false)
        refreshControl.endRefreshing()
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == _collFavorite{
            return favoriteList.count
        }
        return bannerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == _collFavorite{
            return configFavoriteCell(at: indexPath, in: collectionView)
        }else{
            return configBannerCell(at: indexPath, in: collectionView)
        }
        
    }
    
    func configFavoriteCell(at indexPath: IndexPath, in collectionView: UICollectionView) -> FavoriteCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        let item = favoriteList[indexPath.row]
        if let type = FavoriteType(rawValue: item.transType){
            cell._img.image = type.getIcon()
        }
        cell._title.text = item.nickname
        return cell
    }
    
    func configBannerCell(at indexPath: IndexPath, in collectionView: UICollectionView) -> BannerCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
        
        ImageLoader.shared.loadImage(from: URL(string: bannerList[indexPath.row].linkUrl)! ) { image in
            if let image = image{
                cell._img.image = image
                
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == _collBanner{
            ImageLoader.shared.loadImage(from: URL(string: bannerList[indexPath.row].linkUrl)! ) { image in
                
            }
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == _collBanner{
            let visibleRect = CGRect(origin: self._collBanner.contentOffset, size: self._collBanner.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = self._collBanner.indexPathForItem(at: visiblePoint) {
                self._pageView.currentPage = visibleIndexPath.row
                self.counter = visibleIndexPath.row
            }
        }
        
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == _collFavorite{
            let size = _collFavorite.frame.size
            return CGSize(width: size.width / 4, height: size.height)
        }
        let size = _collBanner.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
extension HomeViewController {
    
    func showLoading(){
        gradientLayerUSD.isHidden = false
        gradientLayerKHR.isHidden = false
    }
    func hiddenLoading(){
        gradientLayerUSD.isHidden = true
        gradientLayerKHR.isHidden = true
    }
    
    func setupGradientLayer() {
        
        gradientLayerUSD.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayerUSD.endPoint = CGPoint(x: 1, y: 0.5)
        _lbValueUSD.layer.addSublayer(gradientLayerUSD)
        
        gradientLayerKHR.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayerKHR.endPoint = CGPoint(x: 1, y: 0.5)
        _lbValueKHR.layer.addSublayer(gradientLayerKHR)
        
        let titleGroup = makeAnimationGroup()
        titleGroup.beginTime = 0.0
        
        gradientLayerUSD.add(titleGroup, forKey: "backgroundColor")
        gradientLayerUSD.isHidden = true
        
        gradientLayerKHR.add(titleGroup, forKey: "backgroundColor")
        gradientLayerKHR.isHidden = true
    }
    
    
    func makeAnimationGroup(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
        let animDuration: CFTimeInterval = 1.5
        let anim1 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim1.fromValue = UIColor.gradientLightGrey.cgColor
        anim1.toValue = UIColor.gradientDarkGrey.cgColor
        anim1.duration = animDuration
        anim1.beginTime = 0.0

        let anim2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim2.fromValue = UIColor.gradientDarkGrey.cgColor
        anim2.toValue = UIColor.gradientLightGrey.cgColor
        anim2.duration = animDuration
        anim2.beginTime = anim1.beginTime + anim1.duration

        let group = CAAnimationGroup()
        group.animations = [anim1, anim2]
        group.repeatCount = .greatestFiniteMagnitude
        group.duration = anim2.beginTime + anim2.duration
        group.isRemovedOnCompletion = false

        if let previousGroup = previousGroup {
            group.beginTime = previousGroup.beginTime + 0.33
        }

        return group
    }
}
