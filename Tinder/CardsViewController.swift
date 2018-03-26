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
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        if sender.state == .began {
    
        } else if sender.state == .changed {
            imgView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
        
            if velocity.x > 0 {
                imgView.transform = imgView.transform.rotated(by: CGFloat(0.2 * M_PI / 180))
            } else {
                imgView.transform = imgView.transform.rotated(by: CGFloat(-0.2 * M_PI / 180))
            }
            
        } else if sender.state == .ended {
            UIView.animate(withDuration: 0.2, animations: {
                imgView.center = self.cardInitialCenter
                imgView.transform = self.cardInitailTransfer
            })
            
        }
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
