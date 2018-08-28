//
//  TrackerVC.swift
//  RxReminder
//
//  Created by Yaroslaw Bagriy on 4/4/16.
//

import UIKit

class TrackerVC: UIViewController {
    
    @IBOutlet weak var switchMorning: UISwitch!
    @IBOutlet weak var switchAfternoon: UISwitch!
    @IBOutlet weak var switchEvening: UISwitch!
    @IBOutlet weak var switchBedtime: UISwitch!
    
    @IBOutlet weak var switchReminderMorning: UISwitch!
    @IBOutlet weak var switchReminderAfternoon: UISwitch!
    @IBOutlet weak var switchReminderEvening: UISwitch!
    @IBOutlet weak var switchReminderBedtime: UISwitch!
    
    var storedDate = ""
    var currentdate = ""
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        if let daterecorded = defaults.string(forKey: "storeddate") {
            storedDate = daterecorded
        }
        
        currentdate = getDate()
        
        if currentdate == storedDate {
            
            if let _ = defaults.string(forKey: "takenmorning") {
                switchMorning.setOn(true, animated: true)
            }
            
            if let _ = defaults.string(forKey: "takenafternoon") {
                switchAfternoon.setOn(true, animated: true)
            }
            
            if let _ = defaults.string(forKey: "takenevening") {
                switchEvening.setOn(true, animated: true)
            }
            
            if let _ = defaults.string(forKey: "takenbedtime") {
                switchBedtime.setOn(true, animated: true)
            }
            
        } else if currentdate != storedDate {
            
            defaults.removeObject(forKey: "takenmorning")
            defaults.removeObject(forKey: "takenafternoon")
            defaults.removeObject(forKey: "takenevening")
            defaults.removeObject(forKey: "takenbedtime")
            
            switchMorning.setOn(false, animated: true)
            switchAfternoon.setOn(false, animated: true)
            switchEvening.setOn(false, animated: true)
            switchBedtime.setOn(false, animated: true)
            
        }
        
        if let _ = defaults.string(forKey: "remindermorning") {
            switchReminderMorning.setOn(true, animated: true)
        }
        
        if let _ = defaults.string(forKey: "reminderafternoon") {
            switchReminderAfternoon.setOn(true, animated: true)
        }
        
        if let _ = defaults.string(forKey: "reminderevening") {
            switchReminderEvening.setOn(true, animated: true)
        }
        
        if let _ = defaults.string(forKey: "reminderbedtime") {
            switchReminderBedtime.setOn(true, animated: true)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDate() -> String {
        
        let date = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
        
        return date
        
    }
    
    @IBAction func morningTakenTapped(_ sender: UISwitch) {
        
        storedDate = getDate()
        
        if switchMorning.isOn {
            defaults.set(storedDate, forKey: "storeddate")
            defaults.set(switchMorning.isOn, forKey: "takenmorning")
            switchMorning.setOn(true, animated: true)
        } else {
            if let _ = defaults.string(forKey: "takenmorning") {
                switchMorning.setOn(false, animated: true)
                defaults.removeObject(forKey: "takenmorning")
            }
        }
        
    }
    
    @IBAction func afternoonTakenTapped(_ sender: UISwitch) {
        
        storedDate = getDate()
        
        if switchAfternoon.isOn {
            defaults.set(storedDate, forKey: "storeddate")
            defaults.set(switchAfternoon.isOn, forKey: "takenafternoon")
            switchAfternoon.setOn(true, animated: true)
        } else {
            if let _ = defaults.string(forKey: "takenafternoon") {
                switchAfternoon.setOn(false, animated: true)
                defaults.removeObject(forKey: "takenafternoon")
            }
        }
        
    }
    
    @IBAction func eveningTakenTapped(_ sender: UISwitch) {
        
        storedDate = getDate()
        
        if switchEvening.isOn {
            defaults.set(storedDate, forKey: "storeddate")
            defaults.set(switchEvening.isOn, forKey: "takenevening")
            switchEvening.setOn(true, animated: true)
        } else {
            if let _ = defaults.string(forKey: "takenevening") {
                switchEvening.setOn(false, animated: true)
                defaults.removeObject(forKey: "takenevening")
            }
        }
        
    }
    
    @IBAction func bedtimeTakentapped(_ sender: UISwitch) {
        
        storedDate = getDate()
        
        if switchBedtime.isOn {
            defaults.set(storedDate, forKey: "storeddate")
            defaults.set(switchEvening.isOn, forKey: "takenbedtime")
            switchBedtime.setOn(true, animated: true)
        } else {
            if let _ = defaults.string(forKey: "takenbedtime") {
                switchBedtime.setOn(false, animated: true)
                defaults.removeObject(forKey: "takenbedtime")
            }
        }
        
    }
    
    // reminder functions
    
    var notifyMorning = UILocalNotification()
    var notifyAfternoon = UILocalNotification()
    var notifyEvening = UILocalNotification()
    var notifyBedtime = UILocalNotification()
    
    @IBAction func morningReminderTapped(_ sender: UISwitch) {
        
        if switchReminderMorning.isOn {
            
            defaults.set(switchReminderMorning.isOn, forKey: "remindermorning")
            
            let theDate = Date()
            var cal = Calendar.current
            cal.timeZone = Calendar.current.timeZone
            let fireDate = (cal as NSCalendar).date(bySettingHour: 9, minute: 0, second: 0, of: theDate, options: NSCalendar.Options())
            
            notifyMorning.alertBody = "Did you take your morning pills today?"
            notifyMorning.repeatInterval = NSCalendar.Unit.day
            notifyMorning.fireDate = fireDate
            notifyMorning.soundName = UILocalNotificationDefaultSoundName
            
            UIApplication.shared.scheduleLocalNotification(notifyMorning)
            
        } else {
            
            defaults.removeObject(forKey: "remindermorning")
            
            UIApplication.shared.cancelLocalNotification(notifyMorning)
            
        }
        
    }
    
    @IBAction func afternoonReminderTapped(_ sender: UISwitch) {
        
        if switchAfternoon.isOn {
            
            defaults.set(switchReminderAfternoon.isOn, forKey: "reminderafternoon")
            
            let theDate = Date()
            var cal = Calendar.current
            cal.timeZone = Calendar.current.timeZone
            let fireDate = (cal as NSCalendar).date(bySettingHour: 14, minute: 0, second: 0, of: theDate, options: NSCalendar.Options())
            
            notifyAfternoon.alertBody = "Did you take your afternoon pills today?"
            notifyAfternoon.repeatInterval = NSCalendar.Unit.day
            notifyAfternoon.fireDate = fireDate
            notifyAfternoon.soundName = UILocalNotificationDefaultSoundName
            
            UIApplication.shared.scheduleLocalNotification(notifyAfternoon)
            
        } else {
            
            defaults.removeObject(forKey: "reminderafternoon")
            
            UIApplication.shared.cancelLocalNotification(notifyAfternoon)
            
        }
        
    }
    
    @IBAction func eveningReminderTapped(_ sender: UISwitch) {
        
        if switchEvening.isOn {
            
            defaults.set(switchReminderEvening.isOn, forKey: "reminderevening")
            
            let theDate = Date()
            var cal = Calendar.current
            cal.timeZone = Calendar.current.timeZone
            let fireDate = (cal as NSCalendar).date(bySettingHour: 19, minute: 0, second: 0, of: theDate, options: NSCalendar.Options())
            
            notifyEvening.alertBody = "Did you take your evening pills today?"
            notifyEvening.repeatInterval = NSCalendar.Unit.day
            notifyEvening.fireDate = fireDate
            notifyEvening.soundName = UILocalNotificationDefaultSoundName
            
            UIApplication.shared.scheduleLocalNotification(notifyEvening)
            
        } else {
            
            defaults.removeObject(forKey: "reminderevening")
            
            UIApplication.shared.cancelLocalNotification(notifyEvening)
            
        }
        
    }
    
    @IBAction func bedtimeReminderTapped(_ sender: UISwitch) {
        
        if switchBedtime.isOn {
            
            defaults.set(switchReminderBedtime.isOn, forKey: "reminderbedtime")
            
            let theDate = Date()
            var cal = Calendar.current
            cal.timeZone = Calendar.current.timeZone
            let fireDate = (cal as NSCalendar).date(bySettingHour: 23, minute: 0, second: 0, of: theDate, options: NSCalendar.Options())
            
            notifyBedtime.alertBody = "Did you take your bedtime pills tonight?"
            notifyBedtime.repeatInterval = NSCalendar.Unit.day
            notifyBedtime.fireDate = fireDate
            notifyBedtime.soundName = UILocalNotificationDefaultSoundName
            
            UIApplication.shared.scheduleLocalNotification(notifyBedtime)
            
        } else {
            
            defaults.removeObject(forKey: "reminderbedtime")
            
            UIApplication.shared.cancelLocalNotification(notifyBedtime)
            
        }
        
    }
    
}
