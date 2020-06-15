//
//  HolidayRequest.swift
//  HolidaysApp
//
//  Created by Saranya Kalyanasundaram on 5/27/20.
//  Copyright © 2020 Saranya. All rights reserved.
//

import Foundation

enum HolidayError : Error{
    case noDataAvailable
    case couldNotProcessData
    
}

struct HolidayRequest{
    var requestUrl : URL
    var API_KEY : String = Constants.API_KEY
    
    init(countryCode : String){
        let date  = Date()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy"
        let currentYear = dateFormater.string(from: date)
        
        let resourceString = "https://calendarific.com/api/v2/holidays?&api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        
        guard let requestUrl = URL(string: resourceString) else{
            fatalError()
        }
        self.requestUrl = requestUrl
    }
    
    func getHolidays(completion: @escaping(Result<[HolidayDetail],HolidayError>) ->Void){
        
        //Create
        let dataTask = URLSession.shared.dataTask(with: self.requestUrl) { (data, _, _) in
            guard let jsonData = data else{
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                print("json:\(jsonData)")
                let decoder = JSONDecoder()
                let holidayResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidayResponse.response.holidays
                completion(.success(holidayDetails))
             }
            catch{
                completion(.failure(.couldNotProcessData))
            }
        }
        dataTask.resume()
    }
    
}
