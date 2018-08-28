//
//  Rx+CoreDataProperties.swift
//  RxReminder
//
//  Created by Yaroslaw Bagriy on 4/4/16.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Rx {

    @NSManaged var dosage: String?
    @NSManaged var name: String?
    @NSManaged var time: String?

}
