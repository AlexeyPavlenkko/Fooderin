//
//  String+.swift
//  Fooderin
//
//  Created by Алексей Павленко on 20.09.2022.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
