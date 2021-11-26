//
//  AnswerEntity+CoreDataProperties.swift
//  
//
//  Created by Артём on 26.11.2021.
//
//

import Foundation
import CoreData


extension AnswerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AnswerEntity> {
        return NSFetchRequest<AnswerEntity>(entityName: "AnswerEntity")
    }

    @NSManaged public var text: String?
    @NSManaged public var date: Date?

}
