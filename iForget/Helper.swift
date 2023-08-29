//
//  Helper.swift
//  iForget
//
//  Created by Vinícius Lopes on 08/09/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import Foundation

func getCreationDate(for file: URL) -> Date {
    if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
        let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
        return creationDate
    } else {
        return Date()
    }
}


