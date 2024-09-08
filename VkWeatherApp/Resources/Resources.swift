//
//  Resources.swift
//  VkWeatherApp
//
//  Created by Исмаил Орумбеков on 06.09.2024.
//

import Foundation
import UIKit


struct Resources{
    struct Texts{
        public static let expectedWeather = "Expected weather for today:"
        
    }
    
    struct Colors{
        public static let block = UIColor(hexString: "#262628")
    }
    
    func formatDoubleWithoutDecimal(_ value: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none // Убираем стиль числа
        numberFormatter.maximumFractionDigits = 0 // Без цифр после запятой
        return numberFormatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}
