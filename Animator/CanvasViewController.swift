//
//  CanvasViewController.swift
//  Animator
//
//  Created by Aditya Dhingra on 3/23/17.
//  Copyright © 2017 Aditya Dhingra. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var arrow: UIImageView!
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        var velocity = sender.velocity(in: view)
            
        //Conditional state check
        if sender.state == .began {
            
            trayOriginalCenter = trayView.center
            
        } else if sender.state == .changed {
            
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
            
        } else if sender.state == .ended {
            
            //velocity > 0 -> down
            //else -> up
            
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.4, animations: {
                    self.trayView.center = self.trayDown
                })
            } else {
                UIView.animate(withDuration: 0.4, animations: {
                    self.trayView.center = self.trayUp
                })
            }
            
        }
        
    }
    
    @IBOutlet weak var trayView: UIView!
    
    //Class variables
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayDownOffset = 180
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
        
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        var imageView = sender.view as! UIImageView
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pantan(sender:)))
        
        if sender.state == .began {
            
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(pan)
            
            
            //Animate
            UIView.animate(withDuration: 0.2, animations: {
                imageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            })
            
            
        } else if sender.state == .changed {
            
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
            
        } else if sender.state == .ended {
            
            //Animate
            UIView.animate(withDuration: 0.2, animations: {
                imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
            
    }

    func pantan(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
        } else if sender.state == .changed {
            
             newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
         
            
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
