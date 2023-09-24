//
//  HomeVC.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class HomeVC: BaseVC {
    
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "TableCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "TableCell")        // Do any additional setup after loading the view.
        
        setLayout()
    }
    @IBAction func chonMonPressed(_ sender: UIButton) {
        self.pushVC(controller: ChonMonVC())
    }
    
    
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TableCell", for: indexPath) as? TableCell else {return UICollectionViewCell()}
        
        return cell
    }
    
    func setLayout(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let countItem = C.Screen.WIDTH / 100
        let totalSpaceScreen = C.Screen.WIDTH - countItem  * 100
        let width = 100.0
        let height = 66
        layout.minimumInteritemSpacing = totalSpaceScreen / countItem
        layout.minimumLineSpacing = 20
//        collectionViewFlowLayout.itemSize = CGSize(width: 63, height: 66)

        layout.itemSize.width = width
        layout.itemSize.height = CGFloat(height)
        
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    
    
}
 
