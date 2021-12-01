//
//  ViewController.swift
//  moveYourPhone
//
//  Created by Hojin Ryu on 29/11/21.
//

import UIKit
import CoreMotion
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    var stringColorNames: [String] = ["black", "customYellow", "customPink", "customBrown", "systemGreen", "systemPink", "systemTeal", "systemYellow", "systemBlue", "systemRed", "systemGray", "systemPurple"]
    var colorArray: [UIColor?] = [UIColor.black, UIColor(named: "color1"), UIColor(named: "color2"), UIColor(named: "color3"), UIColor.systemGreen, UIColor.systemPink, UIColor.systemTeal, UIColor.systemYellow, UIColor.systemBlue, UIColor.systemRed, UIColor.systemGray, UIColor.systemPurple]
    var roundColors: [String] = []
    var selectedColors: [String] = []
    var cont: Int = 0
    var point: Int = 0
//    let manager = CMMotionActivityManager()
//    let manager = CMMotionManager()
    let manager = CMPedometer()
    var locationManager: CLLocationManager?
    var previousLat: CLLocationDegrees!
    var previousLong: CLLocationDegrees!
    var targetColorArray: [UIButton] = []
    var isShownColors: Bool = false
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var gameObjectiveLabel: UILabel!
    @IBOutlet weak var targetColor1: UIButton!
    @IBOutlet weak var targetColor2: UIButton!
    @IBOutlet weak var targetColor3: UIButton!
    @IBOutlet weak var targetColor4: UIButton!
    @IBOutlet weak var startButton: UIButton!
  
    @IBOutlet weak var systemBlackButton: UIButton!
    @IBOutlet weak var customYellowButton: UIButton!
    @IBOutlet weak var customPinkButton: UIButton!
    @IBOutlet weak var customBrownButton: UIButton!
    @IBOutlet weak var systemGreenButton: UIButton!
    @IBOutlet weak var systemPinkButton: UIButton!
    @IBOutlet weak var systemTealButton: UIButton!
    @IBOutlet weak var systemYellowButton: UIButton!
    @IBOutlet weak var systemBlueButton: UIButton!
    @IBOutlet weak var systemRedButton: UIButton!
    @IBOutlet weak var systemGrayButton: UIButton!
    @IBOutlet weak var systemPurpleButton: UIButton!
    
    @IBOutlet weak var blockView: UIView!
    @IBOutlet weak var blockIndicator: UIActivityIndicatorView!
    
    
    
    @IBAction func startGameAction(_ sender: Any) {
        gameObjectiveLabel.text = "Memorize the colors below (in 5 seconds)"
        roundColors.removeAll()
        selectedColors.removeAll()
        self.isShownColors = false
        cont = 0
        
        self.targetColor1.isHidden = false
        self.targetColor2.isHidden = false
        self.targetColor3.isHidden = false
        self.targetColor4.isHidden = false
        
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
            self.targetColor1.isHidden = true
            self.targetColor2.isHidden = true
            self.targetColor3.isHidden = true
            self.targetColor4.isHidden = true
            timer.invalidate()
            self.isShownColors = true
            self.gameObjectiveLabel.text = "Repeat the colors"
        }
        
        for i in 0...3 {
            let auxRoundIndex = Int.random(in: 0...colorArray.count-1)
            roundColors.append(stringColorNames[auxRoundIndex])
            targetColorArray[i].backgroundColor = colorArray[auxRoundIndex]
        }
        
        print("roundColors: \(roundColors)")
        
        if startButton.titleLabel?.text == "start again" {
            startButton.setTitle("start", for: .normal)
        }
    }
    
    @IBAction func colorButtons(_ sender: UIButton) {
        if isShownColors {
            switch sender.tag {
            case 0:
                selectedColors.append(stringColorNames[sender.tag])
            case 1:
                selectedColors.append(stringColorNames[sender.tag])
            case 2:
                selectedColors.append(stringColorNames[sender.tag])
            case 3:
                selectedColors.append(stringColorNames[sender.tag])
            case 4:
                selectedColors.append(stringColorNames[sender.tag])
            case 5:
                selectedColors.append(stringColorNames[sender.tag])
            case 6:
                selectedColors.append(stringColorNames[sender.tag])
            case 7:
                selectedColors.append(stringColorNames[sender.tag])
            case 8:
                selectedColors.append(stringColorNames[sender.tag])
            case 9:
                selectedColors.append(stringColorNames[sender.tag])
            case 10:
                selectedColors.append(stringColorNames[sender.tag])
            case 11:
                selectedColors.append(stringColorNames[sender.tag])
            default:
                print("no color")
            }
            
            print(selectedColors)
            if selectedColors[cont] == roundColors[cont] {
                cont += 1
            } else {
                print("errou")
                gameObjectiveLabel.text = "Try again"
                startButton.setTitle("start again", for: .normal)
                point = 0
                
            }
            
            if roundColors.count == cont {
                print("done")
                startButton.setTitle("start again", for: .normal)
                point += 1
                
            }
            pointLabel.text = "Score: \(point)"
        }
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        targetColor1.layer.cornerRadius = 10
        targetColor2.layer.cornerRadius = 10
        targetColor3.layer.cornerRadius = 10
        targetColor4.layer.cornerRadius = 10

        systemBlackButton.layer.cornerRadius = 10
        customYellowButton.layer.cornerRadius = 10
        customPinkButton.layer.cornerRadius = 10
        customBrownButton.layer.cornerRadius = 10
        systemGreenButton.layer.cornerRadius = 10
        systemPinkButton.layer.cornerRadius = 10
        systemTealButton.layer.cornerRadius = 10
        systemYellowButton.layer.cornerRadius = 10
        systemBlueButton.layer.cornerRadius = 10
        systemRedButton.layer.cornerRadius = 10
        systemGrayButton.layer.cornerRadius = 10
        systemPurpleButton.layer.cornerRadius = 10
        
        startButton.layer.cornerRadius = 10
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()

        targetColorArray.append(targetColor1)
        targetColorArray.append(targetColor2)
        targetColorArray.append(targetColor3)
        targetColorArray.append(targetColor4)
        
        gameObjectiveLabel.text = "Memorize the colors below (in 5 seconds)"
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let first = locations.first else { return }
        
        if previousLat == nil || previousLong == nil {
            previousLat = first.coordinate.latitude
            previousLong = first.coordinate.longitude
            return
        }
        
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_US")
        formatter.minimumFractionDigits = 5
        formatter.maximumFractionDigits = 5
        let previousLatString = formatter.string(from: previousLat as NSNumber) ?? ""
        let previousLongString = formatter.string(from: previousLong as NSNumber) ?? ""
//        print("previous:  latitude: \(previousLatString) longitude: \(previousLongString) ")
        
        let currentLatString = formatter.string(from: first.coordinate.latitude as NSNumber) ?? ""
        let currentLongString = formatter.string(from: first.coordinate.longitude as NSNumber) ?? ""
//        print("current:  latitude: \(currentLatString) longitude: \(currentLongString) ")
        
        if previousLatString != currentLatString || previousLongString != currentLongString {
//            print("andou")
            blockView.isHidden = true
            blockIndicator.stopAnimating()
        } else {
//            print("parado")
            blockView.isHidden = false
            blockIndicator.startAnimating()
        }
        previousLat = first.coordinate.latitude
        previousLong = first.coordinate.longitude
        
    }
}
