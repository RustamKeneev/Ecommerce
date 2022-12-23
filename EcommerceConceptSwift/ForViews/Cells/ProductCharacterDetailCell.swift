//
//  ProductCharacterDetailCell.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 19/12/22.
//

import Foundation
import UIKit
import SnapKit


class ProductCharacterDetailCell: UICollectionViewCell {
    
    static let reuseIdentifierCell = "ProductCharacterDetailCell"

    
    public lazy var productCharacterDetailImage: UIImageView = {
        let view  = UIImageView()
        return view
    }()
    
    public lazy var productCharacterDetailUILabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        view.textColor = .gray
        return view
    }()
    
    private lazy var categoryStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [productCharacterDetailImage, productCharacterDetailUILabel])
        view.axis = .vertical
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        backgroundColor = .clear
        layer.cornerRadius = 36
        
        addSubview(productCharacterDetailImage)
        addSubview(productCharacterDetailUILabel)
    }
    
    private func setContraints(){
        productCharacterDetailImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(30)
        }
        productCharacterDetailUILabel.snp.makeConstraints { make in
            make.top.equalTo(productCharacterDetailImage.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupData(productCharacterDetail: ProductCharacterDetail){
        productCharacterDetailImage.image = productCharacterDetail.image
        productCharacterDetailUILabel.text = productCharacterDetail.text
    }
}
