//
//  LineartViewController.swift
//  Enhance Your Art
//
//  Created by Ziyan Mo on 4/2/17.
//  Copyright © 2017 Ziyan Mo. All rights reserved.
//


import UIKit

class LineartViewController: UIViewController {
    
    @IBOutlet weak var Back: UINavigationBar!

    
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!

    var curImage:UIImage!
    
    //@IBOutlet var ZoomGesture: UIPinchGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = curImage

    }
    
    fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
        print("Updating min zoom scale")
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        
        print(scrollView.minimumZoomScale)
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
    
    override func viewWillLayoutSubviews() {
        print("Inside view will layout subviews")
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)

    }
    
    // Allows users to zoom in on their image. 
    // We actually zoom in on uiimageview, not the image itself
    func zoom(sender: UIPinchGestureRecognizer)
    {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageUpdater(){
        imageView.image = curImage
        print(curImage)
    }
    
}

extension LineartViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        print("Outside the class; inside viewforZooming")
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
    }
    
    fileprivate func updateConstraintsForSize(_ size: CGSize) {
        
        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
    
}
