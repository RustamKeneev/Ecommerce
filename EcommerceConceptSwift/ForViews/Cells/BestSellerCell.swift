//
//  BestSellerCell.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 13/12/22.
//

import Foundation
import UIKit
import SnapKit

class BestSellerCell:UICollectionViewCell{
    
    static let reuseIdentifierCell = "BestSellerCell"
    
    private lazy var bestSellersUIView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.addSubview(bestSellerImage)
        view.addSubview(discountDollarUILabel)
        view.addSubview(discountPriceUIlabel)
        view.addSubview(priceWithoutDiscountDollarUILabel)
        view.addSubview(priceWithoutDiscountUILabel)
        view.addSubview(bestSellersProductsTitle)
        bestSellerImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(168)
        }
        discountDollarUILabel.snp.makeConstraints { make in
            make.top.equalTo(bestSellerImage.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(20)
        }
        discountPriceUIlabel.snp.makeConstraints { make in
            make.centerY.equalTo(discountDollarUILabel.snp.centerY)
            make.left.equalTo(discountDollarUILabel.snp.right).offset(8)
        }
        priceWithoutDiscountDollarUILabel.snp.makeConstraints { make in
            make.centerY.equalTo(discountPriceUIlabel.snp.centerY).offset(2)
            make.left.equalTo(discountPriceUIlabel.snp.right).offset(8)
        }
        priceWithoutDiscountUILabel.snp.makeConstraints { make in
            make.centerY.equalTo(priceWithoutDiscountDollarUILabel.snp.centerY)
            make.left.equalTo(priceWithoutDiscountDollarUILabel.snp.right)
        }
        bestSellersProductsTitle.snp.makeConstraints { make in
            make.top.equalTo(discountDollarUILabel.snp.bottom).offset(6)
            make.left.equalTo(discountDollarUILabel.snp.left)
            make.right.equalToSuperview().offset(-16)
        }
        return view
    }()
    
    private lazy var bestSellerImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var likeUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.addSubview(likeUIImage)
        likeUIImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(12)
        }
        return view
    }()
    
    private lazy var likeUIImage: UIImageView = {
        let view = UIImageView()
//        view.image = UIImage.init(named: "not_favorites")
        return view
    }()
    
    private lazy var discountDollarUILabel: UILabel = {
        let view = UILabel()
        view.text = "$"
        view.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        view.textColor = UIColor.init(hex: "#010035")
        return view
    }()
    
    private lazy var discountPriceUIlabel: UILabel = {
        let view  = UILabel()
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        view.textColor = UIColor.init(hex: "#010035")
        return view
    }()
    
    private lazy var priceWithoutDiscountDollarUILabel: UILabel = {
        let view = UILabel()
        view.text = "$"
        view.textColor = UIColor.init(hex: "#CCCCCC")
        view.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        return view
    }()
    
    private lazy var priceWithoutDiscountUILabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.init(hex: "#CCCCCC")
        view.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        return view
    }()
    
    private lazy var bestSellersProductsTitle: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(hex: "#010035")
        view.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        view.numberOfLines = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setContraints()
    }
    
    private func setupViews(){
        addSubview(bestSellersUIView)
        addSubview(likeUIView)
    }
    
    private func setContraints(){
        bestSellersUIView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(228)
        }
        likeUIView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.width.equalTo(24)
        }
    }
    
    func setupData(bestSeller:BestSeller){
        bestSellerImage.kf.setImage(with: URL(string: bestSeller.picture ?? ""))
        discountPriceUIlabel.text = String(bestSeller.discountPrice ?? 0)
        priceWithoutDiscountUILabel.text = String(bestSeller.priceWithoutDiscount ?? 0)
        bestSellersProductsTitle.text = bestSeller.title
        if bestSeller.isFavorites == true {
            print("is_favorites true =====> \(bestSeller.isFavorites)")
            likeUIImage.image = UIImage.init(named: "is_favorites")
        }else if bestSeller.isFavorites == false {
            print("is_favorites false =====> \(bestSeller.isFavorites)")
            likeUIImage.image = UIImage.init(named: "not_favorites")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
