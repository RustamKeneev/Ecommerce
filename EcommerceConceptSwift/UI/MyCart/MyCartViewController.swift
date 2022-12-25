//
//  MyCartViewController.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 20/12/22.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

class MyCartViewController: BaseViewController {
    
    private lazy var myCartViewModel: MyCartViewModel = {
        return MyCartViewModel(delegate: self)
    }()
    
    
    private lazy var addAdressImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(named: "add_adress")
        return view
    }()
    
    private lazy var addAddressUILabel: UILabel = {
        let view = UILabel()
        view.text = "Add address"
        view.textColor = UIColor.init(hex: "#010035")
        view.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return view
    }()
    
    private lazy var myCartUILabel: UILabel = {
        let view = UILabel()
        view.text = "My Cart"
        view.textColor = UIColor.init(hex: "#010035")
        view.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        return view
    }()
    
    private lazy var mainMyCartUIView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#010035")
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.addSubview(myCartTableView)
        myCartTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
//            make.bottom.equalTo(topLineUIView.snp.top)
            make.bottom.equalToSuperview().offset(-218)
        }
        return view
    }()
    
    private lazy var myCartTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
        tableView.register(MyCartCell.self, forCellReuseIdentifier: MyCartCell.reuseIdentifierCell)
        tableView.rowHeight = 88
        tableView.backgroundColor = .clear
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    private lazy var checkoutUIButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.init(hex: "#FF6E4E")
        view.layer.cornerRadius = 10
        view.setTitle("Checkout", for: .normal)
        view.titleLabel?.textColor = .white
        view.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return view
    }()
    
    private lazy var bottomLineUIView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#404068")
        return view
    }()
    
    private lazy var tottalMyCartDataUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(totalUILabel)
        view.addSubview(totalPriceUILabel)
        view.addSubview(deliveryUILabel)
        view.addSubview(freeUILabel)
        totalUILabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(54)
        }
        totalPriceUILabel.snp.makeConstraints { make in
            make.centerY.equalTo(totalUILabel.snp.centerY)
            make.right.equalToSuperview().offset(-24)
        }
        deliveryUILabel.snp.makeConstraints { make in
            make.top.equalTo(totalUILabel.snp.bottom).offset(12)
            make.left.equalTo(totalUILabel.snp.left)
        }
        freeUILabel.snp.makeConstraints { make in
            make.centerY.equalTo(deliveryUILabel.snp.centerY)
            make.right.equalTo(totalPriceUILabel.snp.right)
        }
        return view
    }()
    
    private lazy var totalUILabel: UILabel = {
        let view = UILabel()
        view.text = "Total"
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return view
    }()
    
    private lazy var totalPriceUILabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        view.text = "$6,000 us"
        return view
    }()
    
    private lazy var deliveryUILabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.text = "Delivery"
        return view
    }()
    
    private lazy var freeUILabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        view.text = "Free"
        return view
    }()
    
    private lazy var topLineUIView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#404068")
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCartNavBar()
        configure()
        myCartViewModel.fetchMyCart()
        myCartTableView.allowsSelection = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configure(){
        setupAddSubviews()
        setupAddConstraints()
    }
    
    func setupAddSubviews(){
        view.addSubview(addAdressImage)
        view.addSubview(addAddressUILabel)
        view.addSubview(myCartUILabel)
        view.addSubview(mainMyCartUIView)
        view.addSubview(checkoutUIButton)
        view.addSubview(bottomLineUIView)
        view.addSubview(tottalMyCartDataUIView)
        view.addSubview(topLineUIView)
    }
    
    func setupAddConstraints(){
        addAdressImage.snp.makeConstraints { make in
            make.centerY.equalTo(myCartViews!.snp.centerY)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(36)
        }
        addAddressUILabel.snp.makeConstraints { make in
            make.centerY.equalTo(addAdressImage.snp.centerY)
            make.right.equalTo(addAdressImage.snp.left).offset(-8)
        }
        myCartUILabel.snp.makeConstraints { make in
            make.top.equalTo(myCartViews!.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(16)
        }
        mainMyCartUIView.snp.makeConstraints { make in
            make.top.equalTo(myCartUILabel.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        checkoutUIButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-44)
            make.leading.trailing.equalToSuperview().inset(44)
            make.height.equalTo(54)
        }
        bottomLineUIView.snp.makeConstraints { make in
            make.bottom.equalTo(checkoutUIButton.snp.top).offset(-24)
            make.leading.trailing.equalToSuperview().inset(4)
            make.height.equalTo(2)
        }
        tottalMyCartDataUIView.snp.makeConstraints { make in
            make.bottom.equalTo(bottomLineUIView.snp.top).offset(-2)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(90)
        }
        topLineUIView.snp.makeConstraints { make in
            make.bottom.equalTo(tottalMyCartDataUIView.snp.top).offset(4)
            make.leading.trailing.equalToSuperview().inset(4)
            make.height.equalTo(2)
        }
    }
    
    @objc func oneTapped(_ sender: Any?) {
        print("Tapped")
    }
    func buttonAction(sender:UIButton!)
    {
        print("Button tapped")
    }
    
    func calculateTotal(){
        var totalValue = 0
        for objProduct in myCartViewModel.myCartArrayData {
            totalValue += objProduct.discountPrice ?? 0
        }
        self.totalPriceUILabel.text = "\(totalValue)"
    }
}

extension MyCartViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCartViewModel.myCartArrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyCartCell.reuseIdentifierCell, for: indexPath) as! MyCartCell
        cell.selectionStyle = .none
        let data = myCartViewModel.myCartArrayData[indexPath.row]
        cell.setupData(myCartModel: data)
//        cell.myCartPriceUILabel.text = "\(String(describing: cell.product.discountPrice ?? 0))"
        cell.productIndex = indexPath.row
        cell.cartSelectionDelegate = self
        return cell

    }
}

extension MyCartViewController: UITableViewDelegate{
    
}

extension MyCartViewController: MyCartViewModelDelegate{
    func loadMyCart() {
        myCartTableView.reloadData()
    }
}

extension MyCartViewController: CartSelection{
    func addProductToCart(product: MyCartModel, atindex: Int) {
        self.myCartViewModel.myCartArrayData[atindex] = product
        calculateTotal()
    }
}
