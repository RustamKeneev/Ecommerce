//
//  HomeViewController.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 9/12/22.
//

import Foundation
import UIKit
import SnapKit
import iOSDropDown
import SwiftUI

class HomeViewController: BaseViewController {
    
    private let brandValues = ["Samsung","IPhone","Redmi","Huawei"]
    private let priceValues = ["$300-$500","$500-$800","$900-$1500","$1300-$2500"]
    private let sizeValues = ["4.5 to 5.5 inches","5.5 to 6.5 inches","6.5 to 7.5 inches","4.5 to 5.5 inches"]

    private lazy var fillterImageGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleFillterImage))

    private var filterImageIsTaped: Bool = false
    
    private let horizontalMenuCollectioView = HomeHorizontalMenuCollectioView()
    
    private lazy var filterUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.addGestureRecognizer(fillterImageGesture)
        view.addSubview(fillterImage)
        fillterImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        return view
    }()
    
    private lazy var fillterImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(named: "fillter_nav_bar")
        return view
    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cyan
        return view
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .statusColor
        return indicator
    }()
    
    
    private lazy var selectCategoryUILabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.init(hex: "#010035")
        view.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        view.text = "Select Category"
        return view
    }()
    
    private lazy var viewAllUILabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.init(hex: "#FF6E4E")
        view.text = "view all"
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return view
    }()
    
    private lazy var qrCodeIUImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(named: "qr_code_category")
        view.layer.cornerRadius = 17
        return view
    }()
    
    // MARK: - searchUITextField
    private lazy var searchUITextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Search"
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
        let leftImage = UIImageView(frame: CGRect(x: 10, y: 14, width: 24, height: 24))
        leftImage.tintColor = .gray
        leftImage.image = UIImage.init(named: "search_loop_icon")
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        leftView.addSubview(leftImage)
        view.leftViewMode = .always
        view.leftView = leftView
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var hotSalesUILabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.init(hex: "#010035")
        view.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        view.text = "Hot sales"
        return view
    }()
    
    private lazy var seeMoreUILabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.init(hex: "#FF6E4E")
        view.text = "see more"
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return view
    }()
    
    private lazy var homeUIView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#F8F8F8")
        view.addSubview(hotScalesCollectionView)
        hotScalesCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(182)
        }
        return view
    }()
    
    private lazy var hotScalesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.layer.cornerRadius = 16
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .clear
        cv.register(HotScalesCell.self, forCellWithReuseIdentifier: HotScalesCell.reuseIdentifierCell)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.bounces = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private lazy var bestSellersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //        cv.layer.cornerRadius = 16
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .clear
        cv.register(BestSellerCell.self, forCellWithReuseIdentifier: BestSellerCell.reuseIdentifierCell)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.bounces = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private lazy var bestSellerUILabel: UILabel = {
        let view = UILabel()
        view.text = "Best Seller"
        view.textColor = UIColor.init(hex: "#010035")
        view.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return view
    }()
    
    private lazy var seeMoreBestSellersUILabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.init(hex: "#FF6E4E")
        view.text = "see more"
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return view
    }()
    
    private lazy var expandView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        view.isHidden = true
        view.layer.cornerRadius = 30
        view.addSubview(cancelExpandButton)
        view.addSubview(filterOptionsUILabel)
        view.addSubview(doneUIButton)
        view.addSubview(brandUILabel)
        view.addSubview(brandDropDown)
        view.addSubview(priceUILabel)
        view.addSubview(priceDropDown)
        view.addSubview(sizeUILabel)
        view.addSubview(sizeDropDown)
        cancelExpandButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(38)
        }
        filterOptionsUILabel.snp.makeConstraints { make in
            make.centerY.equalTo(cancelExpandButton.snp.centerY)
            make.centerX.equalToSuperview()
        }
        doneUIButton.snp.makeConstraints { make in
            make.centerY.equalTo(cancelExpandButton.snp.centerY)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(38)
        }
        brandUILabel.snp.makeConstraints { make in
            make.top.equalTo(cancelExpandButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(24)
        }
        brandDropDown.snp.makeConstraints { make in
            make.top.equalTo(brandUILabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(32)
        }
        priceUILabel.snp.makeConstraints { make in
            make.top.equalTo(brandDropDown.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(24)
        }
        priceDropDown.snp.makeConstraints { make in
            make.top.equalTo(priceUILabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(32)
        }
        sizeUILabel.snp.makeConstraints { make in
            make.top.equalTo(priceDropDown.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(24)
        }
        sizeDropDown.snp.makeConstraints { make in
            make.top.equalTo(sizeUILabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(32)
        }
        return view
    }()
    
    private lazy var cancelExpandButton: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(named: "cancel_button")
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCancelImageSelector)))
        return view
    }()
    
    private lazy var filterOptionsUILabel: UILabel = {
        let view = UILabel()
        view.text = "Filter options"
        view.font = UIFont.systemFont(ofSize: 18, weight: .light)
        view.textColor = UIColor.init(hex: "#010035")
        return view
    }()
    
    private lazy var doneUIButton: UIButton = {
        let view = UIButton()
        view.setTitle("Done", for: .normal)
        view.backgroundColor = UIColor.init(hex: "#FF6E4E")
        view.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        view.addTarget(self, action: #selector(doneUIButtonPressed), for: .allTouchEvents)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var brandUILabel: UILabel = {
        let view = UILabel()
        view.text = "Brand"
        view.textColor = UIColor.init(hex: "#010035")
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return view
    }()
    
    private lazy var chooseBrandLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        return view
    }()
    
    private lazy var brandDropDown: DropDown = {
        let view = DropDown()
        view.backgroundColor = .clear
        view.optionArray = brandValues
        view.text = "Choose brand"
        view.addSubview(chooseBrandLabel)
        chooseBrandLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return view
    }()
    
    private lazy var priceUILabel: UILabel = {
        let view = UILabel()
        view.text = "Price"
        view.textColor = UIColor.init(hex: "#010035")
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return view
    }()
    
    private lazy var choosePriceLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        return view
    }()
    
    private lazy var priceDropDown: DropDown = {
        let view = DropDown()
        view.backgroundColor = .clear
        view.optionArray = priceValues
        view.text = "Choose price"
        view.addSubview(choosePriceLabel)
        choosePriceLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return view
    }()
    
    private lazy var sizeUILabel: UILabel = {
        let view = UILabel()
        view.text = "Size"
        view.textColor = UIColor.init(hex: "#010035")
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return view
    }()
    
    private lazy var chooseSizeLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        return view
    }()
    
    private lazy var sizeDropDown: DropDown = {
        let view = DropDown()
        view.backgroundColor = .clear
        view.optionArray = sizeValues
        view.text = "Choose size"
        view.addSubview(chooseSizeLabel)
        chooseSizeLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeNavBar()
        configure()
        loadHomeStoreManager()
        indicator.startAnimating()
        
        brandDropDown.didSelect{(selectedText , index ,id) in
            self.chooseBrandLabel.text = "\(selectedText)"
        }
        priceDropDown.didSelect{(selectedText , index ,id) in
            self.choosePriceLabel.text = "\(selectedText)"
        }
        sizeDropDown.didSelect{(selectedText , index ,id) in
            self.chooseSizeLabel.text = "\(selectedText)"
        }
    }
    
    
    
    var homeStories: [HomeStore]? {
        didSet{
            DispatchQueue.main.async { [self] in
                print("homeStories was Set")
                hotScalesCollectionView.reloadData()
                self.indicator.stopAnimating()
            }
        }
    }
    
    var bestSellers: [BestSeller]? {
        didSet{
            DispatchQueue.main.async {
                print("bestSellers was Set")
                self.bestSellersCollectionView.reloadData()
            }
        }
    }
    
    
    func configure(){
        setupAddSubviews()
        setupAddConstraints()
    }
    
    func loadHomeStoreManager(){
        let homeStoreManager = HomeStoreManager()
        homeStoreManager.fetchHomeData{(homeStore) in
            DispatchQueue.main.async { [self] in
                print(homeStore.homeStore)
            }
            self.homeStories = homeStore.homeStore
            self.bestSellers = homeStore.bestSeller
        }
    }
    
    func setupAddSubviews(){
        view.addSubview(fillterImage)
        view.addSubview(selectCategoryUILabel)
        view.addSubview(viewAllUILabel)
        view.addSubview(horizontalMenuCollectioView)
        view.addSubview(homeUIView)
        view.addSubview(qrCodeIUImage)
        view.addSubview(searchUITextField)
        view.addSubview(hotSalesUILabel)
        view.addSubview(seeMoreUILabel)
        view.addSubview(bestSellerUILabel)
        view.addSubview(seeMoreBestSellersUILabel)
        view.addSubview(bestSellersCollectionView)
        view.addSubview(indicator)
        view.addSubview(filterUIView)
        view.addSubview(expandView)
        horizontalMenuCollectioView.cellDelegate = self
    }
    

    
    func setupAddConstraints(){
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        selectCategoryUILabel.snp.makeConstraints { make in
            make.top.equalTo(filterUIView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        viewAllUILabel.snp.makeConstraints { make in
            make.centerY.equalTo(selectCategoryUILabel.snp.centerY)
            make.right.equalToSuperview().offset(-24)
        }
        horizontalMenuCollectioView.snp.makeConstraints { make in
            make.top.equalTo(selectCategoryUILabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(106)
        }
        qrCodeIUImage.snp.makeConstraints { make in
            make.top.equalTo(horizontalMenuCollectioView.snp.bottom).offset(12)
            make.right.equalToSuperview()
            //            make.width.height.equalTo(34)
        }
        searchUITextField.snp.makeConstraints { make in
            make.centerY.equalTo(qrCodeIUImage.snp.centerY)
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(qrCodeIUImage.snp.left).offset(8)
            make.height.equalTo(40)
        }
        hotSalesUILabel.snp.makeConstraints { make in
            make.top.equalTo(searchUITextField.snp.bottom).offset(18)
            make.left.equalToSuperview().offset(16)
        }
        seeMoreUILabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.centerY.equalTo(hotSalesUILabel.snp.centerY)
        }
        bestSellerUILabel.snp.makeConstraints { make in
            make.top.equalTo(hotScalesCollectionView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        seeMoreBestSellersUILabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.centerY.equalTo(bestSellerUILabel.snp.centerY)
        }
        bestSellersCollectionView.snp.makeConstraints { make in
            make.top.equalTo(bestSellerUILabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        homeUIView.snp.makeConstraints { make in
            make.top.equalTo(hotSalesUILabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-16)
        }

        filterUIView.snp.makeConstraints { make in
            make.top.equalTo(homeBarViews!.snp.top)
            make.right.equalToSuperview().offset(-16)
            make.height.width.equalTo(30)
        }
        expandView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(370)
        }
    }
    
    // MARK: - UI Actions handleFillterImage
    @objc func handleFillterImage() {
        filterImageIsTaped.toggle()
        if filterImageIsTaped {
            print("pressed handleFillterImage")
            UIView.animate(withDuration: 0.8){
                self.expandView.snp.updateConstraints { make in
                    make.bottom.equalToSuperview().offset(-16)
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(376)
                }
                self.expandView.layoutIfNeeded()
                self.expandView.isHidden = false
            }
        } else {
            self.expandView.isHidden = true
        }
    }
    
    @objc func handleCancelImageSelector(){
        print("handleCancelImageSelector  click")
        self.expandView.isHidden = true
    }
    
    @objc func doneUIButtonPressed(){
        print("doneUIButtonPressed clicked")
        let alert = UIAlertController(title: "Filter Info", message: "Your filter succesed", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        self.expandView.isHidden = true
    }
}

extension HomeViewController: SelectedCollectioViewItemProtocol{
    func selectItem(index: IndexPath) {
        print(index)
        switch index.item {
            
        case 0: homeUIView.backgroundColor = UIColor.init(hex: "#F8F8F8")
            break
        case 1: homeUIView.backgroundColor = .red
            print("case 1")
        case 2: homeUIView.backgroundColor = .blue
            print("case 2")
        case 3: homeUIView.backgroundColor = .systemCyan
            print("case 3")
        case 4: homeUIView.backgroundColor = .black
            print("case 4")
            
        default:
            print("default")
        }
    }
}

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == hotScalesCollectionView{
            return homeStories?.count ?? 0
        }else{
            return bestSellers?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == hotScalesCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotScalesCell.reuseIdentifierCell, for: indexPath) as? HotScalesCell else {return UICollectionViewCell()}
            guard let home_store = homeStories?[indexPath.row] else { return UICollectionViewCell()}
            cell.setupData(homeStore: home_store)
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestSellerCell.reuseIdentifierCell, for: indexPath) as? BestSellerCell else {return UICollectionViewCell()}
            guard let best_seller = bestSellers?[indexPath.row] else { return UICollectionViewCell()}
            cell.setupData(bestSeller: best_seller)
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = bestSellers?[indexPath.row]
        if model?.id != nil && ((model?.title) != nil) {
            navigationController?.pushViewController(
                DetailsViewController.newInstanse(
                    id: Int(model?.id ?? 0),
                    categoryTitle: model?.title ?? "",
                    isFavorites: model?.isFavorites ?? false,
                    priceWithoutDiscount: Int(model?.priceWithoutDiscount ?? 0),
                    discountPrice: Int(model?.discountPrice ?? 0),
                    picture: model?.picture ?? ""
                ), animated: true)
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == hotScalesCollectionView {
            return CGSize(width: view.frame.width, height: 182)
        }else {
            let padding: CGFloat =  8
            let collectionViewSize = collectionView.frame.size.width - padding
            let collectionViewSize2 = collectionView.frame.size.height - padding
            return CGSize(width: collectionViewSize/2, height: collectionViewSize2)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

