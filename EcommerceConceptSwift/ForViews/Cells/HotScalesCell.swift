//
//  HotScalesCell.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 12/12/22.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher


class HotScalesCell: UICollectionViewCell{
    
    static let reuseIdentifierCell = "HotScalesCell"
    
    private lazy var hotScalesUIView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .clear
        view.addSubview(hotScalesImage)
        view.addSubview(hotScalesTitleUILabel)
        view.addSubview(hotScalesSubTitleUILabel)
        view.addSubview(buyNowUIButton)
        hotScalesImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(182)
        }
        hotScalesTitleUILabel.snp.makeConstraints { make in
            make.top.equalTo(newUIView.snp.bottom).offset(16)
            make.left.equalTo(newUIView.snp.left)
        }
        hotScalesSubTitleUILabel.snp.makeConstraints { make in
            make.top.equalTo(hotScalesTitleUILabel.snp.bottom).offset(8)
            make.left.equalTo(hotScalesTitleUILabel.snp.left)
        }
        buyNowUIButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-26)
            make.left.equalTo(hotScalesSubTitleUILabel.snp.left)
            make.width.equalTo(100)
        }
        return view
    }()
    
    private lazy var hotScalesImage: UIImageView = {
        let view = UIImageView()
        view.addSubview(newUIView)
        view.layer.cornerRadius = 14
        newUIView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.left.equalToSuperview().offset(24)
            make.height.width.equalTo(30)
        }
        return view
    }()
    
    private lazy var newUIView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#FF6E4E")
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = true
        view.isHidden = true
        view.addSubview(newTextUIlabel)
        newTextUIlabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
//            make.leading.trailing.equalToSuperview().inset(4)
            make.centerX.equalToSuperview()
        }
        return view
    }()
    
    private lazy var newTextUIlabel: UILabel = {
        let view = UILabel()
        view.text = "New"
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        return view
    }()
    
    private lazy var hotScalesTitleUILabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return view
    }()
    
    private lazy var hotScalesSubTitleUILabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return view
    }()
    
    private lazy var buyNowUIButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.setTitle("Buy Now", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        view.titleLabel?.textAlignment = .center
        view.layer.cornerRadius = 8
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setContraints()
    }
    
    private func setupViews(){
        addSubview(hotScalesUIView)
    }
    
    private func setContraints(){
        hotScalesUIView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(192)
        }
    }
    
    func setupData(homeStore:HomeStore){
        hotScalesImage.kf.setImage(with: URL(string: homeStore.picture ?? ""))
        hotScalesTitleUILabel.text = homeStore.title
        if homeStore.isNew == true {
            newUIView.isHidden = false
        }else if homeStore.isNew == false {
            newUIView.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
