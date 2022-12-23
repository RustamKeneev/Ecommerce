//
//  ViewController.swift
//  EcommerceConceptSwift
//
//  Created by Rustam Keneev on 9/12/22.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let catalog = HomeViewController()
        let basket = BasketViewController()
        let favourite = FavouriteViewController()
        let profile = ProfileViewController()
        
        catalog.title = "Explorer"
        basket.title = "Baskets"
        favourite.title = "Favourites"
        profile.title = "Profile"
        
        viewControllers =  [catalog, basket, favourite, profile]
        
        tabBar.items?[0].image = UIImage(named: "home")
        tabBar.items?[1].image = UIImage(named: "basket")
        tabBar.items?[2].image = UIImage(named: "favourite")
        tabBar.items?[3].image = UIImage(named: "profile")
        
        tabBar.layer.masksToBounds = true
        tabBar.isTranslucent = true
        tabBar.backgroundColor = UIColor.init(hex: "#010035")
        
        tabBar.layer.cornerRadius = 16
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
}

