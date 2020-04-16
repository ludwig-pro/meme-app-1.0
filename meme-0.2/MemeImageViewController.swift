//
//  MemeImageViewController.swift
//  meme-0.2
//
//  Created by ludwig vantours on 16/04/2020.
//  Copyright © 2020 LudwigVaan. All rights reserved.
//

import UIKit

class MemeImageViewController: UIViewController {
  
  var meme: Meme!
  
  @IBOutlet weak var displayedImage: UIImageView!
  

  // MARK: Life Cycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    displayedImage.image = meme.memedImage

  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

  }
}
