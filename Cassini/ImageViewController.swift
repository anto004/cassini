//
//  ImageViewController.swift
//  Cassini
//
//  Created by Antonio Bang on 8/30/18.
//  Copyright © 2018 UCLAExtension. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var imageView = UIImageView();

    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.minimumZoomScale = 1/25;
            scrollView.maximumZoomScale = 1.0;
            
            scrollView.delegate = self;
            
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
            scrollView?.contentSize = imageView.frame.size;
            spinner?.stopAnimating();
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
            spinner.startAnimating();
            
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in // without weak self, self is kept in the heap and what if this task takes an hour the user would click back but because of self it would be in the heap, hence we use weak
                let urlContents = try? Data(contentsOf: url)
                
                //when we get the data back, lets put in the main thread
                DispatchQueue.main.async {
                    if let imageData = urlContents, url == self?.imageURL{
                        self?.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
//        if imageURL == nil {
//            imageURL = DemoURLs.stanford;
//        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView; // the view you want to zoom on
    }
    
}
