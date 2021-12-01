//
//  OnboardingViewController.swift
//  moveYourPhone
//
//  Created by Rodrigo Yukio Okido on 01/12/21.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var onboardingButton: UIButton!
    @IBOutlet weak var bestScore: UILabel!
        
    var score = UserDefaults.standard.integer(forKey: "BestScore")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingButton.layer.cornerRadius = 10
        bestScore.text = "Your best score: \(score)"
    }

}
