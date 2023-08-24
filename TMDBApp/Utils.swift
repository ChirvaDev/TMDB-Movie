//
//  Utils.swift
//  TMDBApp
//
//  Created by Pro on 27.03.2023.
//

import Foundation

class Utils {
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormater)
        return jsonDecoder
    }()
    
    static let dateFormater: DateFormater = {
        let dateFormater = DateFormater()
        dateFormater.dateFormat = "yyyy-mm-dd"
        return dateFormater
        
    }
}
