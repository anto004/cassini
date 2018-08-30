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
            if view.window != nil { // check if you're on screen or viewDidAppear
                fetchImage()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated) // when you come on screen
        if imageView.image == nil {
            fetchImage() //make api call in background thread
        }
    }
    
    private func fetchImage(){
        if let url = imageURL {
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents {
                imageView.image = UIImage(data: imageData)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        if imageURL == nil {
            imageURL = DemoURLs.stanford;
        }
    }
    
}
