//
//  MyCartCell.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 21/12/22.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher


protocol ItemTableViewCellDelegate: class {
    func didTapButtonMinus(cell: MyCartModel)
    func didTapButtonPlus(cell: MyCartModel)
}

class MyCartCell: UITableViewCell{
    
    static let reuseIdentifierCell = "MyCartCell"
    
    weak var cellDelegate: ItemTableViewCellDelegate?
    
    
    private lazy var myCartUIImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var deleteUIImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(named: "delete")
        return view
    }()
    
    private lazy var forButtonUIView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#282843")
        view.layer.cornerRadius = 12
        view.addSubview(minusUIImage)
        view.addSubview(countUILabel)
        view.addSubview(plusUIImage)
        minusUIImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.centerX.equalToSuperview()
        }
        countUILabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        plusUIImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
        }
        return view
    }()
    
    private lazy var countUILabel: UILabel = {
        let view = UILabel()
        view.text = "2"
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return view
    }()
    
    private lazy var minusUIImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(named: "minus")
        let tap = UITapGestureRecognizer(target: self, action: #selector(minusTapped))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var plusUIImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(named: "plus")
        return view
    }()
    
    private lazy var myCartTitleUILabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var myCartPriceUILabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.init(hex: "#FF6E4E")
        view.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        view.numberOfLines = 0
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupViews()
        setContraints()
    }
    
    private func setupViews(){
        addSubview(myCartUIImage)
        addSubview(deleteUIImage)
        addSubview(forButtonUIView)
        addSubview(myCartTitleUILabel)
        addSubview(myCartPriceUILabel)
    }
    
    private func setContraints(){
        myCartUIImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(4)
            make.height.width.equalTo(88)
        }
        deleteUIImage.snp.makeConstraints { make in
            make.centerY.equalTo(myCartUIImage.snp.centerY)
            make.right.equalToSuperview().offset(-4)
        }
        forButtonUIView.snp.makeConstraints { make in
            make.centerY.equalTo(deleteUIImage.snp.centerY)
            make.right.equalTo(deleteUIImage.snp.left).offset(-16)
            make.height.equalTo(68)
            make.width.equalTo(26)
        }
        myCartTitleUILabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalTo(myCartUIImage.snp.right).offset(16)
            make.right.equalTo(forButtonUIView.snp.left).offset(-16)
        }
        myCartPriceUILabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalTo(myCartTitleUILabel.snp.left)
        }
    }
    
    @objc func minusTapped(){
        print("click")
//        cellDelegate?.didTapButtonMinus(cell: self)
    }
    
    func setupData(myCartModel:MyCartModel){
        myCartUIImage.image = myCartModel.image
        myCartTitleUILabel.text = myCartModel.text
        myCartPriceUILabel.text = "$\(String(myCartModel.discountPrice))"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
