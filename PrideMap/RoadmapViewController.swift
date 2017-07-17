//
//  RoadmapViewController.swift
//  PrideMap
//
//  Created by Felix Hedlund on 2017-07-13.
//  Copyright © 2017 Felix Hedlund. All rights reserved.
//

import UIKit

class RoadmapViewController: UIViewController {
    @IBOutlet weak var sliceImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(animate), userInfo: nil, repeats: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    }
    
    func animate(){
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            self.sliceImage.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
        }) { (completed) in
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                self.sliceImage.transform = CGAffineTransform.identity
            }, completion: { (completed) in
                UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseIn], animations: {
                    self.sliceImage.frame = CGRect(x: self.view.frame.midX, y: self.view.frame.maxY, width: 0, height: 0)
                }, completion: { (completed) in
                    self.performSegue(withIdentifier: "Onboarding", sender: self.view)
                })
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
