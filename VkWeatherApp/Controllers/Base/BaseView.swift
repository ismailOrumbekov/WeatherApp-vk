//
//  BaseView.swift
//  VkWeatherApp
//
//  Created by Исмаил Орумбеков on 06.09.2024.
//

import Foundation
import UIKit

class BaseView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objc extension BaseView{
    func setUpUI(){
        addViews()
        setUpConstraints()
        configuration()
    }
    func addViews(){}
    func setUpConstraints(){}
    func configuration(){}
}
    
