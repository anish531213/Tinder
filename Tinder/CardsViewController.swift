//
//  CardsViewController.swift
//  Tinder
//
//  Created by Anish Adhikari on 3/25/18.
//  Copyright © 2018 Anish Adhikari. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var cardImageView: UIImageView!
    
    var fadeTransition: FadeTransition!
    
    var cardInitialCenter: CGPoint!
    var cardInitailTransfer: CGAffineTransform!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardInitialCenter = cardImageView.center
        // Do any additional setup after loading the view.
        cardInitailTransfer = cardImageView.transform
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanCardImage(_ sender: UIPanGestureRecognizer) {
        
        let imgView = sender.view as! UIImageView
        //let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        if sender.state == .began {
    
        } else if sender.state == .changed {
            imgView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
        
            if velocity.x > 0 {
                imgView.transform = imgView.transform.rotated(by: CGFloat(0.2 * Double.pi / 180))
            } else {
                imgView.transform = imgView.transform.rotated(by: CGFloat(-0.2 * Double.pi / 180))
            }
            
        } else if sender.state == .ended {
            print(translation.x)
            UIView.animate(withDuration: 0.2, animations: {
                if (translation.x > 150 || translation.x < -150) {
                    imgView.removeFromSuperview()
                } else {
                    imgView.center = self.cardInitialCenter
                    imgView.transform = self.cardInitailTransfer
                }
                
            })
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let profileVC = segue.destination as! CardProfileViewController
        
        let cardImg = cardImageView.image!
        profileVC.profileImage = cardImg
        
        // Set the modal presentation style of your destinationViewController to be custom.
        profileVC.modalPresentationStyle = UIModalPresentationStyle.custom
        
        // Create a new instance of your fadeTransition.
        fadeTransition = FadeTransition()
        
        // Tell the destinationViewController's  transitioning delegate to look in fadeTransition for transition instructions.
        profileVC.transitioningDelegate = fadeTransition
        
        // Adjust the transition duration. (seconds)
        fadeTransition.duration = 0.5
        //print("presenting modally")
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
