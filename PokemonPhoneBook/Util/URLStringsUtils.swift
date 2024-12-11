//
//  URLStringsUtils.swift
//  PokemonPhoneBook
//
//  Created by CHYUN on 12/12/24.
//

import Foundation

class URLStringUtils {
    


    static func getURLString(from url: URL?, option: URLStringOption = .absoluteString) -> String {
        
        if url == nil { return "" }
        
        switch option {
        case .absoluteString:
            return url!.absoluteString         // 전체 URL (scheme, host, path, query 포함)
        case .path:
            return url!.path                   // 경로만
        case .pathWithQuery:
            if let query = url!.query {
                return url!.path + "?" + query // 경로와 쿼리스트링
            }
            return url!.path
        case .host:
            return url!.host ?? ""             // 호스트만
        case .lastPathComponent:
            return url!.lastPathComponent      // 마지막 경로 컴포넌트
        }
    }
    
    /// URL 문자열 변환 옵션
    enum URLStringOption {
        case absoluteString  // 전체 URL
        case path           // 경로만
        case pathWithQuery  // 경로와 쿼리
        case host           // 호스트만
        case lastPathComponent // 마지막 경로 컴포넌트
    }
}
