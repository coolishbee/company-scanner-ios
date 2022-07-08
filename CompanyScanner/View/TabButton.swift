//
//  TabButton.swift
//  CompanyScanner
//
//  Created by coolishbee on 2022/07/08.
//

import SwiftUI

struct TabButton: View {
    @Binding var selected: String
    var image: String
    var animation: Namespace.ID
    
    var body: some View {
        Button(action: {
            withAnimation { selected = image }
        }, label: {
            VStack(spacing: 5, content: {
                Image(systemName: image)
                    .font(.title2)
                    .foregroundColor(selected == image ? Color.green : Color.black.opacity(0.3))
                    .frame(height: 35)
                
                ZStack {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 4)
                    
                    if selected == image {
                        Rectangle()
                            .fill(Color.green)
                            .frame(height: 4)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                }
            })
        })
    }
}
