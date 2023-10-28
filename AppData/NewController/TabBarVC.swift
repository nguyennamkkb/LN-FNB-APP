//
//  TabBarVC.swift
//  LN FNB
//
//  Created by namnl on 18/09/2023.
//

import UIKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeVC = HomeVC()
        let homeNavi = UINavigationController(rootViewController: homeVC)
        
        homeNavi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_home")?.resizeImage(30.0, opaque:false), tag: 1)
        
        let servingVC = DSDangPhucVuVC()
        let servingNavi = UINavigationController(rootViewController: servingVC)
        servingNavi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_bill")?.resizeImage(30.0, opaque:false), tag: 2)
        
        let moreVC = MoreVC()
        let moreNavi = UINavigationController(rootViewController: moreVC)
        moreNavi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_more")?.resizeImage(30.0, opaque:false), tag: 3)
        
        self.viewControllers = [homeNavi, servingNavi, moreNavi]
        setLayout()
    }
    func setLayout(){
        tabBar.barTintColor = C.Color.White
        tabBar.tintColor = C.Color.NYellow
        tabBar.backgroundColor = C.Color.White
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}
