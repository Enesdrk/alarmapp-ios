//
//  ViewController.swift
//  task2
//
//  Created by Enes on 2.09.2023.
//

import UIKit
import UserNotifications

// In this project you can see,
// Create alarm
// Get notification when your app close or background
// Using UNNotificationSound simply

class ViewController: UIViewController {
    
    @IBOutlet weak var datePickerParameter: UIDatePicker! // DatePicker
    @IBOutlet weak var btnAlarmKur: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnAlarmKurActive(_ sender: UIButton) {
        let selectedTime = self.datePickerParameter.date
        let calendar = Calendar.current
  
        let identifier = "wake-up-notification"
        let title = "Wake Up!"
        let body = "You need to wake up, don't be lazy"

        
        let hour = calendar.component(.hour, from: selectedTime)
        let minute = calendar.component(.minute, from: selectedTime)
        let isDaily = true

        let notificatonCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        content.title = title
        content.body  = body
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "Piano.mp3"))
        
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificatonCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificatonCenter.add(request)
        
        showSuccessAlert()
    }
    
    // When alarm is created, a pop-up appears on the screen.
    func showSuccessAlert() {
        let alertController = UIAlertController(title: "Successful", message: "Alarm created.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Done", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        if let topViewController = UIApplication.shared.keyWindow?.rootViewController {
            topViewController.present(alertController, animated: true, completion: nil)
        }
    }
    
}

