//
//  Events.swift
//  TLPEvents
//
//  Created by user143339 on 8/20/18.
//  Copyright © 2018 user143339. All rights reserved.
//

import Foundation

struct Course: Decodable {
    let title: String?
    let date: String?
    let description: String?
}

struct Event: Decodable {
    let title: String?
    let date: String?
    let enddate: String?
    let library: String?
    let description: String?
    let link: String?
}
