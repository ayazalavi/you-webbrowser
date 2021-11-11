//
//  URL+Extension.swift
//  Web Browser
//
//  Created by Ayaz Alavi on 10/11/2021.
//

import Foundation
import UIKit

extension String {
    var isURL: Bool {
        if let url = self.stringURL {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
    
    var stringURL: URL? {
        guard let url = URL(string: self) else { return nil }
        return url
    }
}

