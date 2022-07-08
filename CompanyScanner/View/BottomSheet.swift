//
//  BottomSheet.swift
//  CompanyScanner
//
//  Created by coolishbee on 2022/07/06.
//

import SwiftUI

struct BottomSheet: View {

    @State var top = UIApplication.shared.windows.first?.safeAreaInsets.top
    @State var text = ""
    @State var selected = "house"
    @State var isHide = false
    @Namespace var animation
    
    var body: some View {
        VStack() {
            if !isHide {
                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 50, height: 5)
                    .padding(.top)
//                    .padding(.bottom, 5)
                
                VStack(spacing: 20) {
                    
                    VStack(alignment: .leading, spacing: 10, content: {
                        HStack {
                            Text("게임펍")
                                //.fontWeight(.bold)
                                .font(.headline)
                            
                            Text("게임회사")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                        }
                        
                        HStack {
                            ForEach(1...5, id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .font(.caption2)
                                    .foregroundColor(.red)
                            }
                            
                            Divider()
                            
                            Text("1.2M Views")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                        }.fixedSize(horizontal: false, vertical: true)
                        
                        Text("서울 강서구 공항대로 247 퀸즈나인 C동")
                            .font(.caption)
                                            
                    })
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    //Buttons
                    HStack() {
                        ImageButton(image: "hand.thumbsup", text: "123K")
                        ImageButton(image: "hand.thumbsdown", text: "1K")
                        ImageButton(image: "square.and.arrow.up", text: "Share")
                        ImageButton(image: "square.and.arrow.down", text: "Download")
                    }
                    
                }.padding()
            }
            
            VStack(spacing: 10) {
                Text("게임펍")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                Text("게임회사")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                HStack(spacing: 0) {
                    ForEach(tabItems, id: \.self) { item in
                        GeometryReader { reader in
                            TabButton(selected: $selected, image: item, animation: animation)
                        }
                        .frame(width: 70, height: 50)
                        
                        if item != tabItems.last {
                            Spacer(minLength: 0)
                        }
                    }
                }
            }
            .padding(.top)
            
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                VStack(spacing: 0, content: {
                    GeometryReader { reader -> AnyView in
                        let yAxis = reader.frame(in: .global).minY

                        // logic simple if goes below zero hide nav bar
                        if yAxis < 0 && !isHide {
                            DispatchQueue.main.async {
                                withAnimation {
                                    isHide = true
                                }
                            }
                        }

                        if yAxis > 0 && isHide {
                            DispatchQueue.main.async {
                                withAnimation {
                                    isHide = false
                                }
                            }
                        }

                        return AnyView(
                            Text("")
                                .frame(width: 0, height: 0)
                        )
                    }
                    .frame(width: 0, height: 0)
                    
                    VStack(spacing: 15) {
                        Text("Toys Story")
                            .font(.system(size: 35, weight: .bold))
                        
                        HStack(spacing: 15) {
                            ForEach(1...5, id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Text("Some Scene May Scare Very Young Children")
                            .font(.caption)
                            .padding(.top, 5)
                        
                        Text(plot)
                            .padding(.top, 10)
                        
                        HStack(spacing: 15) {
                            Button(action: {}, label: {
                                Text("Bookmark")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            })
                            
                            Button(action: {}, label: {
                                Text("Buy Tickes")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(Color.red)
                                    .cornerRadius(10)
                            })
                        }
                        .padding()
                        .padding(.top)
                        .padding(.bottom)
                    } //VStack
                })
                                
            }) //ScrollView
        }
//        .padding(.top)
        .background(Color.white)
    }
}

struct ImageButton: View {
    var image: String
    var text: String
    var body: some View {
        Button(action: {}, label: {
            VStack(spacing: 8) {
                Image(systemName: image)
                    .font(.title3)
                
                Text(text)
                    .fontWeight(.semibold)
                    .font(.caption)
            }
        })
        .foregroundColor(.black)
        .frame(maxWidth: .infinity)
    }
}

var tabItems = ["house", "magnifyingglass", "flame", "gearshape"]
