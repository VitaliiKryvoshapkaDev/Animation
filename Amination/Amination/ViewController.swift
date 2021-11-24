//
//  ViewController.swift
//  Amination
//
//  Created by Vitalii Kryvoshapka on 24.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var animatingView: UIView!
    
    // UIDynamic Animation
    @IBOutlet weak var dropViewBatton: UIButton!
    
    
    var animator: UIDynamicAnimator?
    var gravity: UIGravityBehavior?
    var collider: UICollisionBehavior?
    var itemBehaviour: UIDynamicItemBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior()
        collider = UICollisionBehavior()
        itemBehaviour = UIDynamicItemBehavior()
        
        //All elementc collide with out view
        collider?.translatesReferenceBoundsIntoBoundary = true
        collider?.collisionMode = .everything
        
        //Shake button
        dropViewBatton.shake()
        //Crash with button
        collider?.addItem(dropViewBatton)
        
        
        
        //Elastic
        itemBehaviour?.elasticity = 1
        itemBehaviour?.friction = 1
        itemBehaviour?.allowsRotation = true
        
        animator?.addBehavior(gravity!)
        animator?.addBehavior(collider!)
        animator?.addBehavior(itemBehaviour!)
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapDropView() {
        let view = UIView(frame: CGRect(x: dropViewBatton.frame.origin.x, y: 40, width: 30, height: 30))
        view.backgroundColor = #colorLiteral(red: 0.937, green: 0.714, blue: 0.502, alpha: 1.000)
        self.view.addSubview(view)
        
        gravity?.addItem(view)
        collider?.addItem(view)
        itemBehaviour?.addItem(view)
    }
    
    
    
    
    // Cube Animation
    @IBAction func startMove() {
        //Need to animations:
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
    
    // Transform Animation
    @IBAction func startTransform() {
        
        //Create Label
        let lable = UILabel(frame: CGRect(x: 30, y: 30, width: 100, height: 30))
        lable.text = "Swift"
        
        UIView.transition(with: self.animatingView, duration: 2, options: .transitionCurlUp, animations: {
            self.animatingView.addSubview(lable)
        })  { (isFinished) in
            UIView.transition(with: self.animatingView, duration: 2, options: .transitionCrossDissolve,
                animations: {
                lable.removeFromSuperview()
            }, completion: nil)
        }
    }
    
    

    
}

    //add Shake button
public extension UIView {

    func shake(count : Float = 4,for duration : TimeInterval = 0.5,withTranslation translation : Float = 5) {

        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
}
