//
//  HomeView.swift
//  Restart
//
//  Created by Ivan on 21/12/21.
//

import SwiftUI

struct HomeView: View {
  @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
  
  var body: some View {
    VStack(spacing: 20) {
      Text("Home View")
        .font(.largeTitle)
      
      Button(action: {
        isOnboardingViewActive = true
      }) {
        Text("Restart")
          .foregroundColor(.white)
          .padding(.horizontal, 35)
          .padding(.vertical, 8)
          .border(.blue, width: 3)
          .background(.blue)
          .cornerRadius(10)
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
