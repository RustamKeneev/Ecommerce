//
//  HorizontalMenuCollectioViewProductDetailCell.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 19/12/22.
//

import Foundation
import UIKit
import SnapKit

class HorizontalMenuCollectioViewProductDetailCell: UICollectionViewCell {
    
    public lazy var productDetailUILabel: UILabel = {
        let view  = UILabel()
        view.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return view
    }()
    
    public lazy var productDetailUIView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        return view
    }()
    
    private lazy var productDetailStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [productDetailUILabel, productDetailUIView])
        view.axis = .vertical
        return view
    }()
    
    
    override var isSelected: Bool {
        didSet {
            productDetailUILabel.textColor = self.isSelected ? UIColor(hex: "#010035") : .gray

            productDetailUIView.backgroundColor = self.isSelected ? UIColor(hex: "#FF6E4E") : UIColor(hex: "#FFFFFF")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setContraints()
    }
    
    private func setupViews(){
        backgroundColor = .white
//        layer.cornerRadius = 36
        
        addSubview(productDetailUILabel)
        addSubview(productDetailUIView)
    }
    
    private func setContraints(){
        productDetailUILabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        productDetailUIView.snp.makeConstraints { make in
            make.top.equalTo(productDetailUILabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(productDetailPagingModel:ProductDetailPagingModel){
        productDetailUILabel.text = productDetailPagingModel.title
    }
}
