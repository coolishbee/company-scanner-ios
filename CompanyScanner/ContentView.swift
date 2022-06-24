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
    
    
    var body: some View {
        ZStack {
            CoolishMapView(annotations: $viewModel.annotiations, viewModel: viewModel)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Location access denied"),
                          message: Text("Your location is needed"),
                          primaryButton: .cancel(),
                          secondaryButton: .default(Text("Settings"),
                                                    action: {
                                                        self.goToDeviceSettings()
                          }))
            }.edgesIgnoringSafeArea(.all)
        }
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
}
