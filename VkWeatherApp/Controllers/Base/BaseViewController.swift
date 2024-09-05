//
//  BaseViewController.swift
//  VkWeatherApp
//
//  Created by Исмаил Орумбеков on 06.09.2024.
//

import Foundation
import UIKit


class BaseViewController: UIViewController{
    override func viewDidLoad() {
        setUpUI()
    }
}



@objc extension BaseViewController{
    func setUpUI(){
        addViews()
        setUpConstraints()
        configuration()
    }
    
    
    func addViews(){}
    
    func setUpConstraints(){}
    
    func configuration(){}
}

//    override func addViews(){
//        super.addViews()
//    }
//    override func setUpConstraint(){
//        super.setUpConstraint()
//    }
//    override func configuration(){
//        super.configuration()
//    }
//
