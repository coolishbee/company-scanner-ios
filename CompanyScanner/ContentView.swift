//
//  ContentView.swift
//  CompanyScanner
//
//  Created by coolishbee on 2022/06/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    @ObservedObject var viewModel = CompaniesInfoViewModel()
    
    @State var offset: CGFloat = 0
    @State var isTest: Bool = false
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
            
            CoolishMapView(annotations: $viewModel.annotiations, viewModel: viewModel)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Location access denied"),
                          message: Text("Your location is needed"),
                          primaryButton: .cancel(),
                          secondaryButton: .default(Text("Settings"),
                                                    action: {
                                                        self.goToDeviceSettings()
                          }))
            }.ignoresSafeArea(.all, edges: .all)
            
            if viewModel.hasSelectedAnnotation {
                GeometryReader { reader in
                    VStack {
                        
                        BottomSheet(isTest: $isTest)
                            .offset(y: reader.frame(in: .global).height - 200)
                            .offset(y: offset)
                            .gesture(
                                DragGesture()
                                    .onChanged({ value in
                                        withAnimation {
                                            // Check the dirction of scroll
                                            // Scroll upwards
                                            // Use startLocation bcz translation will change when we drag up and down
                                            if value.startLocation.y > reader.frame(in: .global).midX {
                                                if value.translation.height < 0 && offset > (-reader.frame(in: .global).height + 200) {
                                                    offset = value.translation.height
                                                    print("1 ======== \(offset)")                                                    
                                                }
                                            }

                                            if value.startLocation.y < reader.frame(in: .global).midX {
                                                if value.translation.height > 0 && offset < 0 {
                                                    offset = (-reader.frame(in: .global).height + 200) + value.translation.height
                                                    print("2 ======== \(offset)")
                                                }
                                            }
                                        }
                                    })
                                    .onEnded({ value in
                                        withAnimation {
                                            // Check and pull up the screen
                                            if value.startLocation.y > reader.frame(in: .global).midX {
                                                if -value.translation.height > reader.frame(in: .global).midX {
                                                    offset = (-reader.frame(in: .global).height + 200)
                                                    print("3 ======== \(offset)")
                                                    isTest = true
                                                    return
                                                }

                                                offset = 0
                                                print("4 ======== \(offset)")
                                            }

                                            if value.startLocation.y < reader.frame(in: .global).midX {
                                                if value.translation.height < reader.frame(in: .global).midX {
                                                    offset = (-reader.frame(in: .global).height + 200)
                                                    print("5 ======== \(offset)")
                                                    return
                                                }

                                                offset = 0
                                                print("6 ======== \(offset)")
                                                isTest = false
                                            }
                                        }
                                    })
                            ) //gesture
                                                
                    } //VStack
                }
                .ignoresSafeArea(.all, edges: .all)
            }
            
            
            VStack {
                Spacer().frame(height: 45.0)
                if viewModel.canRefresh {
                    Button(action: {
                        self.viewModel.requestCompaniesAPI()
                    }) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                                .font(.body)
                            Text("재검색")
                                .fontWeight(.semibold)
                                .font(.body)
                        }
                        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                        .foregroundColor(Color.black)
                        .background(Color.white)
                        .cornerRadius(40)
                    }
                }
                Spacer()
            }.edgesIgnoringSafeArea(.top)
            ActivityIndicator(isAnimating: $viewModel.isLoading, style: .large)
        }) // ZStack
//        .sheet(isPresented: $viewModel.hasSelectedAnnotations, content: {
//                        
//            CompanyInfoListView(companies: self.viewModel.selectedCompanies,
//                                selectedCompany: self.$viewModel.selectedCompany).onDisappear() {
//                self.viewModel.hasSelectedAnnotation = self.viewModel.selectedCompany != nil
//                if self.viewModel.selectedCompany == nil {
//                    self.clearSelectedAnnotation()
//                }
//            }
//        })
//        .actionSheet(isPresented: $viewModel.hasSelectedAnnotation, content: { () -> ActionSheet in
//            let company = self.viewModel.selectedCompany
//            let title = Text(company?.name ?? "")
//            let subTitle = Text(company?.addr ?? "")
//            return ActionSheet(title: title, message: subTitle, buttons: [
//                .default(Text("길찾기"), action: {
//                    print("TEST")
//                }),
//                .destructive(Text("취소"), action: {
//                    self.clearSelectedAnnotation()
//                })
//            ])
//        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    func goToDeviceSettings() {
        guard let url = URL.init(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func clearSelectedAnnotation() {
        self.viewModel.selectedAnnotation = nil
        self.viewModel.selectedAnnotations = nil
    }
}

var plot = "Nice years earlier, following the events of Toy Story 2, Bo Peep and Woody attempt to rescue RC, Andy's remote-controlled car, from a rainstorm. Just as they finish the rescue, Woody watches as Bo is donated to a new owner, and considers going with her, but ultimately decides to remain with Andy. Years later, a young adult Andy donates them to Bonnie, a younger child, before he goes off to college. While the toys are grateful to have a new child, Woody struggles to adapt to an environment where he is not the favorite as he was with Andy, apparent when Bonnie takes Woody's sheriff badge and puts it on Jessie instead, not even bothering to give him a role during her playtime. On the day of bonnie's kindergarten orientation, Woody worries over her and sneaks into her backpack. After a classmate takes away Boonie's arts and crafts supplies, Woody covertly recovers the materials and various pieces of garbage from the trash, including a plastic spork. Bonnie uses these to create a bipedal spork with googly eyes, whom she dubs Forky. Forky comes to life in Bonnies backpack and begins to experience an existential crisis, thinking he is garbage rather than a toy and wishing to remain in a trash can. As Forky becomes Bonnie's favorite toy, Woody takes it upon himself to prevent Forky from throwing himself away..."
