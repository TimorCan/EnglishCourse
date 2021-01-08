//
//  Course.swift
//  Six
//
//  Created by Jax on 2021/1/7.
//  Copyright © 2021 luxshare-ict. All rights reserved.
//

import Foundation
struct Course:Codable {
    var title:String?
    var Items:[DetailCourse]!
}


struct DetailCourse:Codable {
    var title:String?
    var tips:String?
    var chinese:String?
    var english:String?
    var image:String?
}
