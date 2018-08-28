//
//  AddEditVC.swift
//  RxReminder
//
//  Created by Yaroslaw Bagriy on 4/4/16.
//

import UIKit
import CoreData

class AddEditVC: UIViewController, UITextFieldDelegate {
    
    var newRx : Rx? = nil
    
    let moc = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    var timeToTake = "Morning"
    
    @IBOutlet weak var rxName: UITextField!
    @IBOutlet weak var rxDosage: UITextField!
    @IBOutlet weak var rxTime: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if newRx != nil {
            
            rxName.text = newRx?.name
            rxDosage.text = newRx?.dosage
            timeToTake = (newRx?.time)!
            
            if timeToTake == "Morning" {
                rxTime.selectedSegmentIndex = 0
            } else if timeToTake == "Afternoon" {
                rxTime.selectedSegmentIndex = 1
            } else if timeToTake == "Evening" {
                rxTime.selectedSegmentIndex = 2
            } else if timeToTake == "Bedtime" {
                rxTime.selectedSegmentIndex = 3
            }
            
        }
        
        // set delegates for textfields
        rxName.delegate = self
        rxDosage.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        rxName.resignFirstResponder()
        rxDosage.resignFirstResponder()
        
        return true
    }
    
    func dismissVC() {
        
        navigationController?.popToRootViewController(animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func timeDidChange(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            
        case 0:
            timeToTake = "Morning"
        case 1:
            timeToTake = "Afternoon"
        case 2:
            timeToTake = "Evening"
        case 3:
            timeToTake = "Bedtime"
        default:
            break
        }
        
    }
    
    @IBAction func saveTapped(_ sender: AnyObject) {
        
        if newRx == nil {
            addRx()
        } else {
            editRx()
        }
        
        dismissVC()
    }
    
    func addRx() {
        
        let ent = NSEntityDescription.entity(forEntityName: "Rx", in: moc)
        
        let newRx = Rx(entity: ent!, insertInto: moc)
        
        newRx.name = rxName.text!
        newRx.dosage = rxDosage.text!
        newRx.time = timeToTake
        
        do {
            try moc.save()
        } catch {
            print("Failed to save new rx")
            return
        }
        
    }
    
    func editRx() {
        
        newRx?.name = rxName.text!
        newRx?.dosage = rxDosage.text!
        
        switch timeToTake {
            
            case "Morning":
                rxTime.selectedSegmentIndex = 0
            case "Afternoon":
                rxTime.selectedSegmentIndex = 1
            case "Evening":
                rxTime.selectedSegmentIndex = 2
            case "Bedtime":
                rxTime.selectedSegmentIndex = 3
        default:
            break
            
        }
        
        newRx!.time = timeToTake
        
        do {
            try moc.save()
        } catch {
            print("Error saving edit")
            return
        }
        
    }
    
    
    
    
    
    
    

}
