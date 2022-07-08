//
//  CompanyInfoListView.swift
//  CompanyScanner
//
//  Created by coolishbee on 2022/06/27.
//

import SwiftUI

struct CompanyInfoListView: View {
    @State var companies: [CompanyInfo]
    @Binding var selectedCompany: CompanyInfo?
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("")) {
                    ForEach(companies) { company in
                        Button(action: {
                            self.selectedCompany = company
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Image("building")
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.black)
                                    .scaledToFit()
                                Text("\(company.name) (\(company.addr))")
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                        }
                    }//ForEach
                    .frame(height: 45)
                }
            }//List
            .listStyle(GroupedListStyle())
            .listRowBackground(Color.clear)
            .navigationBarTitle("회사 정보")
        }
    }
}
