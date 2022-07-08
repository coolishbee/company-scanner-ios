//
//  CompaniesInfoViewModel.swift
//  CompanyScanner
//
//  Created by coolishbee on 2022/06/23.
//

import SwiftUI
import MapKit

class CompaniesInfoViewModel: ObservableObject {
    
    @Published var annotiations: [CompanyAnnotation]?
    
    @Published var hasSelectedAnnotation: Bool = false
    var selectedAnnotation: CompanyAnnotation? {
        didSet {
            self.selectedCompany = self.selectedAnnotation?.company
            hasSelectedAnnotation = self.selectedCompany != nil
        }
    }
    
    @Published var hasSelectedAnnotations: Bool = false
    var selectedAnnotations: [CompanyAnnotation]? {
        didSet {
            if let selectedAnnotations = selectedAnnotations, !selectedAnnotations.isEmpty {
                hasSelectedAnnotations = true
            } else {
                hasSelectedAnnotations = false
            }
        }
    }
    
    @Published var selectedCompany: CompanyInfo?
    
    var selectedCompanies: [CompanyInfo] {
        guard let annotations = self.selectedAnnotations else {
            return []
        }
        var companies: [CompanyInfo] = []
        for annotation in annotations {
            companies.append(annotation.company)
        }
        return companies
    }
    
    var regionTuple: (lati: Double, lng: Double)?
    var companies: [CompanyInfo]? {
        didSet {
            refreshAnnotations()
        }
    }
    
    @Published var showMapAlert = false
    
    @Published var isLoading = false
    @Published var canRefresh = false
    var isRefreshed = false
    
    func requestCompaniesAPI() {
        print("requestCompaniesAPI")
        
        //network io
        
        self.isRefreshed = true
        self.isLoading = false
        self.canRefresh = false
        
        let testCompany = CompanyInfo(code: AnyIntValue.int(1), name: "게임펍", addr: "퀸즈파크나인", type: "게임회사", lat: AnyDoubleValue.double(37.557772), lng: AnyDoubleValue.double(126.834715))
        let test2Company = CompanyInfo(code: AnyIntValue.int(1), name: "컴투스", addr: "퀸즈파크나인", type: "게임회사", lat: AnyDoubleValue.double(37.556572), lng: AnyDoubleValue.double(126.834715))
        self.companies = [testCompany, test2Company]
    }
    
    private func refreshAnnotations() {
        guard let companies = self.companies else {
            self.annotiations = nil
            return
        }
        
        let companyAnnotations = CompanyAnnotation.make(from: companies)
        if !companyAnnotations.isEmpty {
            self.annotiations = companyAnnotations
        } else {
            self.annotiations = nil
        }
    }
}
