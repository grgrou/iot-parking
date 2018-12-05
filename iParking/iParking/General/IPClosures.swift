//
//  IPClosures.swift
//  iParking
//
//  Created by Felix Chacaltana on 10/13/18.
//  Copyright © 2018 iParking. All rights reserved.
//

import UIKit

typealias Success           = ()-> Void
typealias ErrorMessage      = (_ message: String)-> Void
typealias ArrayParkings     = (_ arrayParking: [IPParkingBE])-> Void
typealias DniInformation    = (_ name: String, _ lastName: String)-> Void
