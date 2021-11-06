//
//  TimerCount+CoreDataProperties.swift
//  
//
//  Created by Фаддей Гусаров on 05.11.2021.
//
//

import Foundation
import CoreData


extension TimerCount {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimerCount> {
        return NSFetchRequest<TimerCount>(entityName: "TimerCount")
    }

    @NSManaged public var timerCount: Int64

}
