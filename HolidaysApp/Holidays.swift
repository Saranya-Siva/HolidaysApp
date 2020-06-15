//
//  Holidays.swift
//  HolidaysApp
//
//  Created by Saranya Kalyanasundaram on 5/27/20.
//  Copyright © 2020 Saranya. All rights reserved.
//

import Foundation


struct HolidayResponse : Decodable{
    var response : HolidaysList
}
struct HolidaysList : Decodable{
    var holidays : [HolidayDetail]
}

struct HolidayDetail : Decodable{
    var name : String
    var date : DateInfo
}

struct DateInfo : Decodable{
    var iso : String
}
