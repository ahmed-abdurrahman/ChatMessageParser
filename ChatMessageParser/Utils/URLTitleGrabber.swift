//
//  URLTitleGrabber.swift
//  ChatMessageParser
//
//  Created by Ahmed Abdurrahman on 3/1/16.
//  Copyright © 2016 Atlassian. All rights reserved.
//
import Alamofire
import SwiftyJSON

import Foundation
class URLTitleGrabber {
    
    static let YahooYqlURL = "https://query.yahooapis.com/v1/public/yql"
    
    private static func getQueryParamsForUrl(url: String) -> [String: String] {
        let params = ["format":"json",
            "q":"SELECT * FROM html WHERE url=\"\(url)\" and compat=\"html5\" and xpath=\"//xhtml:title|//title\" | truncate(count=1)"]
        
        return params
    }

    static func getURLsTitles(urls: [String], completion: (urlsWithTitles: [[String:String]])-> Void){
        var urlsWithTitles = [[String:String]]()
        
        for url in urls {
            let params = getQueryParamsForUrl(url)
            Alamofire.request(.GET, YahooYqlURL, parameters: params, encoding: ParameterEncoding.URL, headers: nil).validate().responseJSON { response -> Void in
                
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        let title = json["query"]["results"]["title"]
                        if title != "null" {
                            urlsWithTitles.append([url:title.stringValue])
                        } else {
                            urlsWithTitles.append([url:""])
                        }
                    }
                case .Failure(_):
                    urlsWithTitles.append([url:""])
                }
                
                if urlsWithTitles.count == urls.count {
                    // All completions handlers are called, result ready to be sent
                    completion(urlsWithTitles: urlsWithTitles)
                }
            }
        }
    }
    
}