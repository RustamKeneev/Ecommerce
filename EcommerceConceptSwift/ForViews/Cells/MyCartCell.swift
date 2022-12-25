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

protocol CartSelection {
    func addProductToCart(product : MyCartModel, atindex : Int)
}

class MyCartCell: UITableViewCell{
    
    var product = MyCartModel()
    private var counterValue = 1
    var productIndex = 0
    
    var cartSelectionDelegate: CartSelection?
    
    static let reuseIdentifierCell = "MyCartCell"
    
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
            make.top.equalToSuperview().offset(4)
            make.centerX.equalToSuperview()
        }
        countUILabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        plusUIImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-2)
        }
        return view
    }()
    
    public lazy var countUILabel: UILabel = {
        let view = UILabel()
        view.text = "1"
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return view
    }()
    
    public lazy var minusUIImage: UIButton = {
        let view = UIButton()
        view.setImage(UIImage.init(named: "minus"), for: .normal)
        view.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        return view
    }()
    
    public lazy var plusUIImage: UIButton = {
        let view = UIButton()
        view.setImage(UIImage.init(named: "plus"), for: .normal)
        view.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var myCartTitleUILabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        view.numberOfLines = 0
        return view
    }()
    
    public lazy var myCartPriceUILabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.init(hex: "#FF6E4E")
        view.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        view.numberOfLines = 0
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    @objc func minusButtonTapped(){
        print("click ------")
        if(counterValue != 1){
            counterValue -= 1;
        }
        self.countUILabel.text = "\(counterValue)"
        product.discountPrice = counterValue
        cartSelectionDelegate?.addProductToCart(product: product, atindex: productIndex)
    }
//
    @objc func plusButtonTapped(){
        print("click ++++++")
        counterValue += 1;
        self.countUILabel.text = "\(counterValue)"
        product.discountPrice = counterValue
        cartSelectionDelegate?.addProductToCart(product: product, atindex: productIndex)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
//        contentView.addSubview(plusUIImage)

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
    
    
    func setupData(myCartModel:MyCartModel){
//        myCartUIImage.image = myCartModel.image
        myCartTitleUILabel.text = myCartModel.text
        myCartPriceUILabel.text = "$\(String(describing: myCartModel.discountPrice ?? 0))"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
