//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Omar Mujtaba on 19/1/20.
//  Copyright © 2020 AmmoLogic Training. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: SentMemesBaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: Layout definitions
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload the data when returning to the screen
        collectionView!.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Build and populate our custom MemeCollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! MemeCollectionViewCell
        
        if let meme = memes?[(indexPath as IndexPath).row] {
            cell.memeImage.image = meme.memedImage
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.openMemeDetailsViewController(meme: memes?[(indexPath as IndexPath).row])
    }
    
    // MARK: Set collection view cell size
    private func setCellSize() {
        let space: CGFloat = 3.0
        let dimension = calculteCellSize(space)
    
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    private func calculteCellSize(_ space: CGFloat) -> CGFloat {
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        
        // Select a baseWidth to calculate the cell size
        // If the screen is portrait, we should do screenWidth/3
        // If the screen is landscapes we should do screenWidth/3
        let currentScreenOrientation = UIApplication.shared.statusBarOrientation
        let baseWidth = currentScreenOrientation.isPortrait ? screenWidth : screenHeight

        return (baseWidth - (2 * space)) / 3.0
    }
}
