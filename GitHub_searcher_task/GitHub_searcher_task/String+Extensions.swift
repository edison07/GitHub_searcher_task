//
//  String+Extensions.swift
//  GitHub_Searcher
//
//  Created by edisonlin on 2022/3/5.
//

import Foundation

extension String {
    func nextPagePath() -> String? {
        let links = self.components(separatedBy: ",")
        
        var dictionary: [String: String] = [:]
        links.forEach({
            let components = $0.components(separatedBy:"; ")
            let remove1 = components[0].replacingOccurrences(of: "<", with: "")
            let remove2 = remove1.replacingOccurrences(of: ">", with: "")
            let cleanSpace = remove2.trimmingCharacters(in: .whitespaces)
            dictionary[components[1]] = cleanSpace
        })
        
        if let nextPagePath = dictionary["rel=\"next\""] {
            print("nextPagePath: \(nextPagePath)")
            return nextPagePath
        }
        
        if let lastPagePath = dictionary["rel=\"last\""] {
            print("lastPagePath: \(lastPagePath)")
        }
        return nil
    }
    
    func getQueryStringParameter(param: String) -> String? {
      guard let url = URLComponents(string: self) else { return nil }
      return url.queryItems?.first(where: { $0.name == param })?.value
    }
}
