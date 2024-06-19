//
//  MotivationInfoEntity+CoreDataProperties.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 12.06.2024.
//
//

import Foundation
import CoreData


extension MotivationInfoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MotivationInfoEntity> {
        return NSFetchRequest<MotivationInfoEntity>(entityName: "MotivationInfoEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var text: String?
    @NSManaged public var title: String?

}

extension MotivationInfoEntity : Identifiable {

}
