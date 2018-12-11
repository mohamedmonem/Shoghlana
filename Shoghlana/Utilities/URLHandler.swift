//
//  URLHandler.swift
//  Shoghlana
//
//  Created by apple on 8/11/18.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation

class URLHandler {
    
    static let youtubeBaseUrl = "https://www.youtube.com/embed/"
    
    static let APP_URL = "http://shoglana.com/api/"
    
    static let Files_URL = "http://sayartk.mobile-app-company.com/admin/app/webroot/files/"
    
    
    static func getUrl(for file: String) -> String {
        let url = APP_URL + file
        return url
    }
    
    
    
}
