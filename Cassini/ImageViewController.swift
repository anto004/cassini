//
//  ImageViewController.swift
//  Cassini
//
//  Created by Antonio Bang on 8/30/18.
//  Copyright © 2018 UCLAExtension. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var imageURL: URL?{
        didSet{
            imageView.image = nil;
            fetchImage()
        }
    }
    
    private func fetchImage(){
        
    }
    
}
