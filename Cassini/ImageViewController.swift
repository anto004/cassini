//
//  ImageViewController.swift
//  Cassini
//
//  Created by Antonio Bang on 8/30/18.
//  Copyright © 2018 UCLAExtension. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    var imageView = UIImageView();

    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.addSubview(imageView)
        }
    }
    
    var imageURL: URL?{
        didSet{
            imageView.image = nil;
            if view.window != nil { // check if you're on screen or viewDidAppear
                fetchImage()
            }
        }
    }
    
    private var image: UIImage? {
        get{
            return imageView.image
        }
        set{
            imageView.image = newValue;
            imageView.sizeToFit();
            scrollView.contentSize = imageView.frame.size;
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
                image = UIImage(data: imageData)
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
