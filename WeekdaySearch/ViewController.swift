//
//  ViewController.swift
//  WeekdaySearch
//
//  Created by Rustem Supayev on 24.04.2021.
//

import UIKit
import Pastel
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var dayTF: UITextField!
    @IBOutlet weak var monthTF: UITextField!
    @IBOutlet weak var yearTF: UITextField!
    @IBOutlet weak var resultInfoLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateLabel()
    }
    
    func setupUI() {
        
        // TextField animations
        dayTF.center.x = self.view.frame.width + 50
        UIView.animate(withDuration: 1.0, delay: 00, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {
            self.dayTF.center.x = self.view.frame.width / 2
        }, completion: nil)
        monthTF.center.x = self.view.frame.width + 50
        UIView.animate(withDuration: 2.0, delay: 00, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {
            self.monthTF.center.x = self.view.frame.width / 2
        }, completion: nil)
        yearTF.center.x = self.view.frame.width + 50
        UIView.animate(withDuration: 3.0, delay: 00, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {
            self.yearTF.center.x = self.view.frame.width / 2
        }, completion: nil)
        
        // Dynamic background
        let pastelView = PastelView(frame: view.bounds)
        
        pastelView.startPastelPoint = .bottomRight
        pastelView.endPastelPoint = .topLeft
        pastelView.animationDuration = 3.0
        
        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                              UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])
        
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
    }
    
    func animateLabel() {
        let str = "Апта күні:"
        for i in str {
            AudioServicesPlaySystemSound(1306)
            resultInfoLabel.text! += "\(i)"
            RunLoop.current.run(until: Date() + 0.2)
        }
    }
    
    @IBAction func findDayBtn(_ sender: UIButton) {
        sender.pulsate()
        
        if let day = dayTF.text,
           let month = monthTF.text,
           let year = yearTF.text {
            
            let  calendar = Calendar.current
            var dateComponents = DateComponents()
            dateComponents.day = Int(day)
            dateComponents.month = Int(month)
            dateComponents.year = Int(year)
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "kk")
            dateFormatter.dateFormat = "EEEE"
            
            guard let date = calendar.date(from: dateComponents) else { return }
            
            let weekday = dateFormatter.string(from: date)
            
            resultLabel.text = weekday.capitalized
            
            if let dayComponent = dateComponents.day,
               let monthComponent = dateComponents.month,
               let yearComponent = dateComponents.year {
                
                if dayComponent > 31 || monthComponent > 12 {
                    Vibration.error.vibrate()
                    sender.shake()
                    resultLabel.text = "Күн табылмаған"
                }
            } else {
                Vibration.error.vibrate()
                sender.shake()
                resultLabel.text = "Күнді таңдаңыз"
            }
            
        } else {
            sender.shake()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
