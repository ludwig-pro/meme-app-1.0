//
//  CollectionViewController.swift
//  meme-0.2
//
//  Created by ludwig vantours on 16/04/2020.
//  Copyright © 2020 LudwigVaan. All rights reserved.
//

import Foundation
import UIKit

class MemesCollectionViewController: UICollectionViewController {
  
  var memes: [Meme]! {
    let object = UIApplication.shared.delegate
    let appDelegate = object as! AppDelegate
    return appDelegate.memes
  }
  
  @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    let space:CGFloat = 3.0
    let dimension = (view.frame.size.width - (2 * space)) / 3.0
    
    flowLayout.minimumInteritemSpacing = space
    flowLayout.minimumLineSpacing = space
    flowLayout.itemSize = CGSize(width: dimension, height: dimension)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    collectionView?.reloadData()
  }

  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection indexPath : Int) -> Int {
    return self.memes.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MemesCollectionViewCell
    let meme = self.memes[indexPath.row]
    
    cell.memeImage.image = meme.memedImage
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
    
    let memeImageViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeImageViewController") as! MemeImageViewController
    memeImageViewController.meme = self.memes[indexPath.row]
    self.navigationController!.pushViewController(memeImageViewController, animated: true)
    
  }
}

