//
//  CustomSearchBar.swift
//  VkWeatherApp
//
//  Created by Исмаил Орумбеков on 09.09.2024.
//

import Foundation
import UIKit

class CustomSearchBar: UISearchBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let textField = self.value(forKey: "searchField") as? UITextField {
            textField.textColor = UIColor.white
        }
    }
}
