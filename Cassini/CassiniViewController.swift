//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Antonio Bang on 8/31/18.
//  Copyright © 2018 UCLAExtension. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            if let url = DemoURLs.NASA[identifier] {
                if let imageVC = segue.destination as? ImageViewController {
                    imageVC.imageURL = url;
                    imageVC.title = (sender as? UIButton)?.currentTitle;
                }
            }
        }
    }

}
