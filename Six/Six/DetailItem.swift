//
//  DetailItem.swift
//  Six
//
//  Created by Jax on 2021/1/6.
//  Copyright © 2021 luxshare-ict. All rights reserved.
//

import Foundation

 struct DetailItem:Codable {
        var inboxType:String?
        var type:String?
        var source:ItemSource!
        var image:ItemImage!
        var title:String?
        var url:String?
        var text:String?
        var audioType:String?
        var commentCount:Int
        
       struct ItemSource:Codable {
          var displayName:String?
          var username:String?
       }


       struct ItemImage:Codable {
          var url:String?
          var _url:String?
       }


    }
