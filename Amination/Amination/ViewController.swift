//
//  ViewController.swift
//  Amination
//
//  Created by Vitalii Kryvoshapka on 24.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var animatingView: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    // Cube Animation
    @IBAction func startMove() {
        
        let bacgroudColor = animatingView.backgroundColor
        let alpha = animatingView.alpha
        let center = animatingView.center
        let transform = animatingView.transform
        
        UIView.animate(withDuration: 4) {
            self.animatingView.backgroundColor = .yellow
            self.animatingView.alpha = 0
            self.animatingView.center = CGPoint(x: 400, y: 700)
            self.animatingView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        } completion: { isFinished in
            if isFinished {
                UIView.animate(withDuration: 4, delay: 2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
                    self.animatingView.backgroundColor = bacgroudColor
                    self.animatingView.alpha = alpha
                    self.animatingView.center = center
                    self.animatingView.transform = transform
                }, completion: nil)
            }
        }
    }
}

