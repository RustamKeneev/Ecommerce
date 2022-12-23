//
//  HorizontalMenuCollectioViewCell.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 11/12/22.
//

import Foundation
import UIKit
import SnapKit

class HorizontalMenuCollectioViewHomeCell: UICollectionViewCell {
    
    public lazy var categoryImage: UIImageView = {
        let view  = UIImageView()
        return view
    }()
    
    public lazy var categoryUILabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return view
    }()
    
    private lazy var categoryStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [categoryImage, categoryUILabel])
        view.axis = .vertical
        return view
    }()
    
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = self.isSelected ? UIColor(hex: "#FF6E4E") : UIColor(hex: "#FFFFFF")
            categoryUILabel.textColor = self.isSelected ? UIColor(hex: "#FF6E4E") : .black
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        backgroundColor = .white
        layer.cornerRadius = 36
        
        addSubview(categoryImage)
        addSubview(categoryUILabel)
    }
    
    private func setContraints(){
        categoryImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(30)
        }
        categoryUILabel.snp.makeConstraints { make in
            make.top.equalTo(categoryImage.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            
        }
    }
    
    func setupData(categoryModel:CategoryModel){
        categoryImage.image = categoryModel.image
        categoryUILabel.text = categoryModel.text
    }
}
