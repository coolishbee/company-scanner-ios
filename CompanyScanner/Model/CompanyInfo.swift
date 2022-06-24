//
//  CompanyInfo.swift
//  CompanyScanner
//
//  Created by coolishbee on 2022/06/23.
//

import Foundation
import MapKit


struct CompanyInfo: Codable, Identifiable {
    var id: Int {
        return code.value
    }
    
    let code: AnyIntValue
    let name, addr, type: String
    let lat, lng: AnyDoubleValue?
    //let stockAt, remainStat, createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case name, addr, type, lat, lng
//        case stockAt = "stock_at"
//        case remainStat = "remain_stat"
//        case createdAt = "created_at"
    }
}

extension CompanyInfo {
    var latitude: Double {
        return lat?.value ?? 0
    }
    
    var longitude: Double {
        return lng?.value ?? 0
    }
    
    
}

/*
 code*    string
 식별 코드

 name*    string
 이름

 addr*    string
 주소

 type*    string
 회사 유형[플랫폼: '01', 게임: '02', 교육: '03']

 lat*    number($float)
 위도

 lng*    number($float)
 경도

 
 */
