//
//  ICEScanViewControllerDelegate.swift
//  ICE
//
//  Created by Andrea Cabral on 02.11.14.
//  Copyright (c) 2014 Andrea Cabral. All rights reserved.
//

import Foundation
import UIKit

protocol ICEScanViewControllerDelegate {
    
    func ICEScanDoneFromViewController(viewController: UIViewController, withImage: ICEScan) -> Void

}