//
//  ViewController.swift
//  moveYourPhone
//
//  Created by Hojin Ryu on 29/11/21.
//

import UIKit
import CoreMotion
import CoreLocation
import Combine

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    var stringColorNames: [String] = ["black", "customYellow", "customPink", "customBrown", "systemGreen", "systemOrange", "systemTeal", "systemYellow", "systemBlue", "systemRed", "systemGray", "systemPurple"]
    var colorArray: [UIColor?] = [UIColor.black, UIColor(named: "color1"), UIColor(named: "color2"), UIColor(named: "color3"), UIColor.systemGreen, UIColor.systemOrange, UIColor.systemTeal, UIColor.systemYellow, UIColor.systemBlue, UIColor.systemRed, UIColor.systemGray, UIColor.systemPurple]
    var roundColors: [String] = []
    var selectedColors: [String] = []
    var cont: Int = 0
    var point: Int = 0
    var countdown: Int = 15
//    let manager = CMMotionActivityManager()
//    let manager = CMMotionManager()
    let manager = CMPedometer()
    var locationManager: CLLocationManager?
    var previousLat: CLLocationDegrees!
    var previousLong: CLLocationDegrees!
    var targetColorArray: [UIButton] = []
    var isShownColors: Bool = false
    let location = CurrentValueSubject<CLLocationCoordinate2D, Never>(CLLocationCoordinate2D(latitude: 0, longitude: 0))
    var subscription: AnyCancellable?
    var finished: Bool = false
    
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
        
        systemBlackButton.isHidden = false
        customYellowButton.isHidden = false
        customPinkButton.isHidden = false
        customBrownButton.isHidden = false
        systemGreenButton.isHidden = false
        systemPinkButton.isHidden = false
        systemTealButton.isHidden = false
        systemYellowButton.isHidden = false
        systemBlueButton.isHidden = false
        systemRedButton.isHidden = false
        systemGrayButton.isHidden = false
        systemPurpleButton.isHidden = false

        
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
            self.targetColor1.isHidden = true
            self.targetColor2.isHidden = true
            self.targetColor3.isHidden = true
            self.targetColor4.isHidden = true
            timer.invalidate()
            self.isShownColors = true
        }
        
        
        for i in 0...3 {
            let auxRoundIndex = Int.random(in: 0...colorArray.count-1)
            roundColors.append(stringColorNames[auxRoundIndex])
            
            targetColorArray[i].backgroundColor = colorArray[auxRoundIndex]
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.countdown -= 1
            
            if self.countdown <= 10 {
                self.gameObjectiveLabel.text = "Repeat the colors. Time left: \(self.countdown)s"
                if self.countdown == 0 {
                    if self.finished {
                        self.gameObjectiveLabel.text = "Well Done"
                    } else {
                        self.gameObjectiveLabel.text = "Try again"
                    }
                    
                    
                    self.systemBlackButton.isHidden = true
                    self.customYellowButton.isHidden = true
                    self.customPinkButton.isHidden = true
                    self.customBrownButton.isHidden = true
                    self.systemGreenButton.isHidden = true
                    self.systemPinkButton.isHidden = true
                    self.systemTealButton.isHidden = true
                    self.systemYellowButton.isHidden = true
                    self.systemBlueButton.isHidden = true
                    self.systemRedButton.isHidden = true
                    self.systemGrayButton.isHidden = true
                    self.systemPurpleButton.isHidden = true
                    
                    self.startButton.setTitle("start again", for: .normal)
                    self.point = 0
                    timer.invalidate()
                    self.countdown = 15
                    self.finished = false
                }
            }

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
                self.countdown = 1
                gameObjectiveLabel.text = "Try again"
                
                systemBlackButton.isHidden = true
                customYellowButton.isHidden = true
                customPinkButton.isHidden = true
                customBrownButton.isHidden = true
                systemGreenButton.isHidden = true
                systemPinkButton.isHidden = true
                systemTealButton.isHidden = true
                systemYellowButton.isHidden = true
                systemBlueButton.isHidden = true
                systemRedButton.isHidden = true
                systemGrayButton.isHidden = true
                systemPurpleButton.isHidden = true
                
                startButton.setTitle("start again", for: .normal)
                point = 0
            }
            
            if roundColors.count == cont {
                print("done")
                finished = true
                countdown = 1
                startButton.setTitle("start again", for: .normal)
                point += 1
                if UserDefaults.standard.integer(forKey: "BestScore") < point {
                    UserDefaults.standard.set(point, forKey: "BestScore")
                }
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
        
        self.navigationController?.navigationBar.isHidden = true
        subscription = location.throttle(for: .seconds(0.5), scheduler: DispatchQueue.main, latest: true).receive(on: DispatchQueue.main).sink { [self] coordinate in
//            print(coordinate)
//
            if previousLat == nil || previousLong == nil {
                previousLat = coordinate.latitude
                previousLong = coordinate.longitude
                return
            }

            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.locale = Locale(identifier: "en_US")
            formatter.minimumFractionDigits = 8
            formatter.maximumFractionDigits = 8
            let previousLatString = formatter.string(from: previousLat as NSNumber) ?? ""
            let previousLongString = formatter.string(from: previousLong as NSNumber) ?? ""
//            print("previous:  latitude: \(previousLatString) longitude: \(previousLongString) ")

            let currentLatString = formatter.string(from: coordinate.latitude as NSNumber) ?? ""
            let currentLongString = formatter.string(from: coordinate.longitude as NSNumber) ?? ""
//            print("current:  latitude: \(currentLatString) longitude: \(currentLongString) ")
            
            print(distanceInKmBetweenEarthCoordinates(lat1: previousLatString, lon1: previousLongString, lat2: currentLatString, lon2: currentLongString))
            if distanceInKmBetweenEarthCoordinates(lat1: previousLatString, lon1: previousLongString, lat2: currentLatString, lon2: currentLongString) > 0.0003 {
    //            print("andou")
                blockView.isHidden = true
                blockIndicator.stopAnimating()
            } else {
    //            print("parado")
                blockView.isHidden = false
                blockIndicator.startAnimating()
            }
            previousLat = coordinate.latitude
            previousLong = coordinate.longitude
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let first = locations.first else { return }
        
        location.send(first.coordinate)
    }
    
    func degreesToRadians(degrees: Double) -> Double {
      return degrees * Double.pi / 180;
    }

    func distanceInKmBetweenEarthCoordinates(lat1: String, lon1: String, lat2: String, lon2: String) -> Double {
        let earthRadiusKm: Double = 6371;

        let dLat = degreesToRadians(degrees: Double(lat2)!-Double(lat1)!);
        let dLon = degreesToRadians(degrees: Double(lon2)!-Double(lon1)!);

        let aux_lat1 = degreesToRadians(degrees: Double(lat1)!);
        let aux_lat2 = degreesToRadians(degrees: Double(lat2)!);

        let a = sin(dLat/2) * sin(dLat/2)
        let b = sin(dLon/2) * sin(dLon/2)
        let c = cos(aux_lat1) * cos(aux_lat2);
        let d = 2 * atan2(sqrt((a+b)*c), sqrt(1-((a+b)*c)));
        return earthRadiusKm * d;
    }
}
