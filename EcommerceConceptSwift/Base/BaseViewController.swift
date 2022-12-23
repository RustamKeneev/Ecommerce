//
//  BaseViewController.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 9/12/22.
//

import Foundation
import UIKit
import SnapKit

class BaseViewController: UIViewController{
    
    var navBarViews: UIView? = nil
    var homeBarViews: UIView? = nil
    var productDetailsViews: UIView? = nil
    var myCartViews: UIView? = nil
    
    var statusBarAdressTitle: UILabel? = nil
    var productDetailsTitle: UILabel? = nil

    var adressImage: UIImageView? = nil
    var arrowBack: UIImageView? = nil
    var arrowBackMyCart: UIImageView? = nil

    var chevronDownNavBarImage: UIImageView? = nil
    var fillterNavBarImage: UIImageView? = nil

    
    let statusBarHeight = UIApplication.shared.connectedScenes
        .filter {$0.activationState == .foregroundActive }
        .map {$0 as? UIWindowScene }
        .compactMap { $0 }
        .first?.windows
        .filter({ $0.isKeyWindow }).first?
        .windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    
    func homeNavBar(){
        homeBarViews = UIView()
        homeBarViews?.backgroundColor = UIColor.init(hex: "#F8F8F8")
        view.addSubview(homeBarViews ?? UIView())
        homeBarViews?.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.equalTo((navBarViews ?? UIView()).snp.bottom)
            make.height.equalTo(40)
        }
        
        statusBarAdressTitle = UILabel()
        statusBarAdressTitle?.text = "Zihuatanejo, Gro"
        statusBarAdressTitle?.textColor = UIColor.init(hex: "#010035")
        statusBarAdressTitle?.font = UIFont.init(name: "Gilroy-Bold", size: 16)
        homeBarViews?.addSubview(statusBarAdressTitle ?? UILabel())
        statusBarAdressTitle?.snp.makeConstraints { (make) in
            make.center.equalToSuperview().inset(16)
        }

        adressImage = UIImageView()
        adressImage?.image = UIImage.init(named: "adress_marker")
        statusBarAdressTitle?.addSubview(adressImage ?? UIImageView())
        adressImage?.snp.makeConstraints { (make) in
            make.right.equalTo((statusBarAdressTitle ?? UILabel()).snp.left).offset(-8)
            make.centerY.equalToSuperview()
        }
        
        chevronDownNavBarImage = UIImageView()
        chevronDownNavBarImage?.image = UIImage.init(named: "chevron_down_nav_bar")
        statusBarAdressTitle?.addSubview(chevronDownNavBarImage ?? UIImageView())
        chevronDownNavBarImage?.snp.makeConstraints { (make) in
            make.left.equalTo((statusBarAdressTitle ?? UILabel()).snp.right).offset(8)
            make.centerY.equalToSuperview()
        }
    }
    
    func productDetailsNavBar(){
        productDetailsViews = UIView()
        productDetailsViews?.backgroundColor = UIColor.init(hex: "#F8F8F8")
        view.addSubview(productDetailsViews ?? UIView())
        productDetailsViews?.snp.makeConstraints({ make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.equalTo((navBarViews ?? UIView()).snp.bottom)
            make.height.equalTo(40)
        })
        
        arrowBack = UIImageView()
        arrowBack?.isUserInteractionEnabled = true
        let cameraTap = UITapGestureRecognizer(target: self, action: #selector(cameraTapped))
        arrowBack?.addGestureRecognizer(cameraTap)
        arrowBack?.image = UIImage.init(named: "arrow_left")
        view?.addSubview(arrowBack ?? UIImageView())
        arrowBack?.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().inset(8)
            make.top.equalTo((navBarViews ?? UIView()).snp.bottom).offset(4)
            make.height.width.equalTo(30)
        }
    }
    
    @objc func cameraTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func myCartNavBar(){
        myCartViews = UIView()
        myCartViews?.backgroundColor = UIColor.init(hex: "#F8F8F8")
        view.addSubview(myCartViews ?? UIView())
        myCartViews?.snp.makeConstraints({ make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.equalTo((navBarViews ?? UIView()).snp.bottom)
            make.height.equalTo(40)
        })
        
        arrowBackMyCart = UIImageView()
        arrowBackMyCart?.isUserInteractionEnabled = true
        let cameraTap = UITapGestureRecognizer(target: self, action: #selector(cameraTapped))
        arrowBackMyCart?.addGestureRecognizer(cameraTap)
        arrowBackMyCart?.image = UIImage.init(named: "arrow_left")
        view?.addSubview(arrowBackMyCart ?? UIImageView())
        arrowBackMyCart?.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo((navBarViews ?? UIView()).snp.bottom).offset(4)
            make.height.width.equalTo(36)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hex: "#F8F8F8")
        settingUI()
    }
    
    func settingUI(){
        
        navBarViews = UIView()
        navBarViews?.backgroundColor = UIColor.init(hex: "#F8F8F8")
        view.addSubview(navBarViews ?? UIView())
        navBarViews?.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
