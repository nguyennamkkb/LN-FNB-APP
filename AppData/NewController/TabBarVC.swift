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
//        let img1 = UIImage(named: "ic_home")
//        img1?.resizeImage(<#T##dimension: CGFloat##CGFloat#>, opaque: <#T##Bool#>)
//        img1?.size.height = 25.0
        homeNavi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_home")?.resizeImage(30.0, opaque:false), tag: 1)
//        homeNavi.tabBarItem.badgeColor = UIColor.white
//        homeNavi.tabBarItem.
        
        
        let servingVC = DSDangPhucVuVC()
        let servingNavi = UINavigationController(rootViewController: servingVC)
        servingNavi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_bill")?.resizeImage(30.0, opaque:false), tag: 2)
//        servingNavi.tabBarItem.badgeColor = UIColor.white
        
        let moreVC = MoreVC()
        let moreNavi = UINavigationController(rootViewController: moreVC)
        moreNavi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_more")?.resizeImage(30.0, opaque:false), tag: 3)
//        moreNavi.tabBarItem.badgeColor = UIColor.white
        
        self.viewControllers = [homeNavi, servingNavi, moreNavi]
        setLayout()
    }
    func setLayout(){
        tabBar.barTintColor = C.Color.White
        tabBar.tintColor = C.Color.Green
        tabBar.backgroundColor = C.Color.Navi
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
