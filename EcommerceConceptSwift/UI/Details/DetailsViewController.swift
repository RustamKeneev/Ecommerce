//
//  DetailsViewController.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 18/12/22.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class DetailsViewController: BaseViewController {
    
    private var id: Int? = nil
    private var categoryTitle: String? = nil
    private var isFavorites: Bool? = nil
    private var priceWithoutDiscount: Int? = nil
    private var discountPrice: Int? = nil
    private var picture: String? = nil
//    private var model: MyCartModel()
    
    static func newInstanse(id: Int, categoryTitle: String, isFavorites: Bool, priceWithoutDiscount: Int,discountPrice: Int,picture: String) -> DetailsViewController {
        let viewController = DetailsViewController()
        viewController.id = id
        viewController.categoryTitle = categoryTitle
        viewController.isFavorites = isFavorites
        viewController.priceWithoutDiscount = priceWithoutDiscount
        viewController.discountPrice = discountPrice
        viewController.picture = picture
        return viewController
    }
    
    private let productDetailHorizontalMenuCollectioView = ProductDetailHorizontalMenuCollectioView()
    
    private lazy var viewModelProductCharacterDetail: ProductCharacterDetailViewModel = {
        return ProductCharacterDetailViewModel(delegate: self)
    }()
    
    private lazy var viewModelSaveMyCartViewModel: SaveMyCartViewModel = {
        return SaveMyCartViewModel(delegate: self)
    }()

    
    private lazy var firstMemoryGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleFirstMemoryUIView))
    private lazy var secondtMemoryGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSecondMemoryUIView))
    private lazy var addCcartGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleAddCartUIView))

    private var firstMemoryIsTaped: Bool = false
    private var secondMemoryIsTaped: Bool = false
    
    private lazy var basketUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(basketUIImage)
        basketUIImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        return view
    }()
    
    private lazy var basketUIImage: UIImageView = {
        let view  = UIImageView()
        view.image = UIImage.init(named: "basket_colored")
        return view
    }()
    
    private lazy var productDetailUIImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var bottomProductDetailUIView: UIView = {
        let view  = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.addSubview(isFavouriteProductDetailUIImage)
        view.addSubview(productDetailUILabel)
        view.addSubview(productDetailStarsUIImage)
        view.addSubview(productDetailHorizontalMenuCollectioView)
        view.addSubview(productDetailSecondUIView)
        isFavouriteProductDetailUIImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(32)
        }
        productDetailUILabel.snp.makeConstraints { make in
            make.centerY.equalTo(isFavouriteProductDetailUIImage.snp.centerY)
            make.left.equalToSuperview().offset(24)
            make.right.equalTo(isFavouriteProductDetailUIImage.snp.left).offset(8)
        }
        productDetailStarsUIImage.snp.makeConstraints { make in
            make.top.equalTo(productDetailUILabel.snp.bottom).offset(4)
            make.left.equalTo(productDetailUILabel.snp.left)
        }
        productDetailHorizontalMenuCollectioView.snp.makeConstraints { make in
            make.top.equalTo(productDetailStarsUIImage.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        productDetailSecondUIView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(134)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        return view
    }()
    
    private lazy var isFavouriteProductDetailUIImage: UIImageView = {
        let view = UIImageView()
        view.isHidden = true
        return view
    }()
    
    private lazy var productDetailUILabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.init(hex: "#010035")
        view.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var productDetailStarsUIImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(named: "five_stars")
        return view
    }()
    
    private lazy var productDetailSecondUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = false
        view.addSubview(productCharacterDetailCollectionView)
        view.addSubview(selectColorAndCapacityUILabel)
        view.addSubview(firstCheckBoxUIButton)
        view.addSubview(secondCheckBoxUIButton)
        view.addSubview(firstMemoryUIView)
        view.addSubview(secondMemoryUIView)
        view.addSubview(addToCardUIView)
        productCharacterDetailCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        selectColorAndCapacityUILabel.snp.makeConstraints { make in
            make.top.equalTo(productCharacterDetailCollectionView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        firstCheckBoxUIButton.snp.makeConstraints { make in
            make.top.equalTo(selectColorAndCapacityUILabel.snp.bottom).offset(16)
            make.left.equalTo(selectColorAndCapacityUILabel.snp.left)
            make.height.width.equalTo(40)
        }
        secondCheckBoxUIButton.snp.makeConstraints { make in
            make.centerY.equalTo(firstCheckBoxUIButton.snp.centerY)
            make.left.equalTo(firstCheckBoxUIButton.snp.right).offset(16)
            make.height.width.equalTo(40)
        }
        firstMemoryUIView.snp.makeConstraints { make in
            make.centerY.equalTo(secondCheckBoxUIButton.snp.centerY)
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        secondMemoryUIView.snp.makeConstraints { make in
            make.centerY.equalTo(firstMemoryUIView.snp.centerY)
            make.left.equalTo(firstMemoryUIView.snp.right).offset(24)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        addToCardUIView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(54)
        }
        return view
    }()
    
    private lazy var productCharacterDetailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .clear
        cv.register(ProductCharacterDetailCell.self, forCellWithReuseIdentifier: ProductCharacterDetailCell.reuseIdentifierCell)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.bounces = false
        cv.showsHorizontalScrollIndicator = false
        cv.isHidden = false
        return cv
    }()
    
    private lazy var selectColorAndCapacityUILabel: UILabel = {
        let view = UILabel()
        view.text = "Select color and capacity"
        view.textColor = UIColor.init(hex: "#010035")
        view.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return view
    }()
    
    private lazy var firstCheckBoxUIButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.init(hex: "#772D03")
        view.layer.cornerRadius = 20
        view.addTarget(self, action: #selector(checkMarkTappedOne), for: .touchDown)
        return view
    }()
    
    private lazy var secondCheckBoxUIButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.init(hex: "#010035")
        view.layer.cornerRadius = 20
        view.addTarget(self, action: #selector(checkMarkTappedTwo), for: .touchDown)
        return view
    }()
    
    private lazy var firstMemoryUIView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#FF6E4E")
        view.layer.cornerRadius = 10
        view.addGestureRecognizer(firstMemoryGesture)
        view.addSubview(firstMemoryUILabel)
        firstMemoryUILabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        return view
    }()
    
    private lazy var firstMemoryUILabel: UILabel = {
        let view = UILabel()
        view.text = "128"
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return view
    }()
    
    private lazy var secondMemoryUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.addGestureRecognizer(secondtMemoryGesture)
        view.addSubview(secondMemoryUILabel)
        secondMemoryUILabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        return view
    }()
    
    private lazy var secondMemoryUILabel: UILabel = {
        let view = UILabel()
        view.text = "256"
        view.textColor = .gray
        view.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return view
    }()
    
    private lazy var addToCardUIView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#FF6E4E")
        view.layer.cornerRadius = 10
        view.addGestureRecognizer(addCcartGesture)
        view.addSubview(addToCartUILabel)
        view.addSubview(discountPriceUILabel)
        addToCartUILabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(24)
        }
        discountPriceUILabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-24)
        }
        return view
    }()
    
    private lazy var addToCartUILabel: UILabel = {
        let view = UILabel()
        view.text = "Add to Cart"
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return view
    }()
    
    private lazy var discountPriceUILabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return view
    }()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        productDetailsNavBar()
        configure()
        viewModelProductCharacterDetail.fetchProductCharacterDetail()
        selectedFirstUIButton()
    }
    
    func configure(){
        setupAddSubviews()
        setupAddConstraints()
        loadingProductDetail()
    }
    
    func setupAddSubviews(){
        view.addSubview(basketUIView)
        view.addSubview(productDetailUIImage)
        view.addSubview(bottomProductDetailUIView)
        productDetailHorizontalMenuCollectioView.cellDelegate = self
    }
    
    func setupAddConstraints(){
        basketUIView.snp.makeConstraints { make in
            make.centerY.equalTo(productDetailsViews!.snp.centerY)
            make.right.equalToSuperview().offset(-16)
            make.height.width.equalTo(30)
        }
        productDetailUIImage.snp.makeConstraints { make in
            make.top.equalTo(productDetailsViews!.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(334)
        }
        bottomProductDetailUIView.snp.makeConstraints { make in
            make.top.equalTo(productDetailUIImage.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func loadingProductDetail(){
        self.productDetailUIImage.kf.setImage(with: URL(string: picture ?? ""))
        if isFavorites == true {
            isFavouriteProductDetailUIImage.image = UIImage.init(named: "is_favourite_product_detail")
            isFavouriteProductDetailUIImage.isHidden = false
        }else {
            isFavouriteProductDetailUIImage.isHidden = true
        }
        self.productDetailUILabel.text = categoryTitle
        self.discountPriceUILabel.text =  "$\(String(discountPrice ?? 0))"
    }
    
    func selectedFirstUIButton(){
        firstCheckBoxUIButton.setImage(UIImage(named:"-"), for: .normal)
        firstCheckBoxUIButton.setImage(UIImage(named:"done_btn"), for: .selected)
        
        secondCheckBoxUIButton.setImage(UIImage(named:"-"), for: .normal)
        secondCheckBoxUIButton.setImage(UIImage(named:"done_btn"), for: .selected)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- checkMarkTappedOne
    @objc func checkMarkTappedOne(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
    }
    
    //MARK:- checkMarkTappedTwo
    @objc func checkMarkTappedTwo(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
    }
    
    @objc func handleFirstMemoryUIView() {
        firstMemoryIsTaped.toggle()
        if firstMemoryIsTaped {
            firstMemoryUIView.backgroundColor = .clear
            firstMemoryUILabel.textColor = .gray
            secondMemoryUIView.backgroundColor = UIColor.init(hex: "#FF6E4E")
            secondMemoryUILabel.textColor = .white
        }else {
            firstMemoryUIView.backgroundColor = UIColor.init(hex: "#FF6E4E")
            firstMemoryUILabel.textColor = .white
            secondMemoryUIView.backgroundColor = .clear
            secondMemoryUILabel.textColor = .gray
        }
    }
    
    @objc func handleSecondMemoryUIView() {
        secondMemoryIsTaped.toggle()
        if secondMemoryIsTaped {
            firstMemoryUIView.backgroundColor = .clear
            firstMemoryUILabel.textColor = .gray
            secondMemoryUIView.backgroundColor = UIColor.init(hex: "#FF6E4E")
            secondMemoryUILabel.textColor = .white
        }else {
            firstMemoryUIView.backgroundColor = UIColor.init(hex: "#FF6E4E")
            firstMemoryUILabel.textColor = .white
            secondMemoryUIView.backgroundColor = .clear
            secondMemoryUILabel.textColor = .gray
        }
    }
    
    @objc func handleAddCartUIView(){
        navigationController?.pushViewController(MyCartViewController(), animated: true)
        viewModelSaveMyCartViewModel.saveMyCartToDatabase()
    }
}


extension DetailsViewController: SelectedProductDetailsCollectioViewItemProtocol{
    func selectItem(index: IndexPath) {
        print("SelectedProductDetailsCollectioViewItemProtocol")
        switch index.item {
            
        case 0: productDetailSecondUIView.backgroundColor = UIColor.init(hex: "#FFFFFF")
            self.productDetailSecondUIView.isHidden = false
            break
        case 1: productDetailSecondUIView.backgroundColor = .red
            self.productDetailSecondUIView.isHidden = true
            print("case 1")
        case 2: productDetailSecondUIView.backgroundColor = .blue
            self.productDetailSecondUIView.isHidden = true
            print("case 2")
        default:
            print("default")
        }
    }
    
}

//MARK: - UICollectionViewDataSource
extension DetailsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModelProductCharacterDetail.productCharacterDetailArrayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCharacterDetailCell.reuseIdentifierCell, for: indexPath) as? ProductCharacterDetailCell else {return UICollectionViewCell()}
        let productCharacterDetailData = viewModelProductCharacterDetail.productCharacterDetailArrayData[indexPath.item]
        cell.setupData(productCharacterDetail: productCharacterDetailData)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension DetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected \(indexPath)")
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 4, height: 46)
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


extension DetailsViewController: ProductCharacterDetailViewModelDelegate{
    func loadProductCharacterDetail() {
        productCharacterDetailCollectionView.reloadData()
    }
}


extension DetailsViewController: SaveMyCartDelegate{
    func showSaveMyCart() {
        print("test save")
    }
}
