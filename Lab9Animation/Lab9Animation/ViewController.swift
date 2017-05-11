//
//  ViewController.swift
//  Lab9Animation
//
//  Created by DUC NGUYEN on 11/05/2017.
//  Copyright © 2017 DUC NGUYEN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var gameTimer: Timer?
    var gravity: UIGravityBehavior?
    var animator: UIDynamicAnimator?
    var img = [UIImage(named: "redballoon"),
               UIImage(named: "greenballoon"),
               UIImage(named: "blueballoon")]
    var speed: Double?
    var count: Int = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var speedSlider: UISlider!
    @IBAction func speedControl(_ sender: UISlider) {
        speed = Double(speedSlider.value)
        let vector = CGVector(dx: 0.0, dy: speed!)
        print("\(speed)")
        gravity?.gravityDirection = vector
        animator?.addBehavior(gravity!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //set timer to show balloon
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.addBalloons(_ :)), userInfo: nil, repeats: true)
        //register an animator
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior(items: [])
        
        let vector = CGVector(dx: 0.0, dy: 0.1)
        print("\(speed)")
        gravity?.gravityDirection = vector
        animator?.addBehavior(gravity!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addBalloons(_ : Any){
        let xCoordinate = arc4random() % UInt32(self.view.bounds.width)
        let index = Int(arc4random_uniform(3))
        //Create a button, set Image, assign touchUpInside handler, add it to the view and gravity animator
        let btn = UIButton(frame: CGRect(x: Int(xCoordinate), y: 60, width: 50, height: 50))
        btn.setImage(img[index], for: .normal)
        btn.addTarget(self, action: #selector(self.didPopBalloon(sender:)), for: .touchUpInside)
        self.view.addSubview(btn)
        
        gravity?.addItem(btn as UIView)
        
    }
    
    func didPopBalloon(sender: UIButton){
        sender.setImage(UIImage(named: "exploded"), for: .normal)
        UIView.animate(withDuration: 0.4, animations: {sender.alpha = 0}, completion: {(true) in sender.removeFromSuperview()})
        count += 1
        scoreLabel.text = "Score: \(count) balloons"
        scoreLabel.sizeToFit()
    }

}

