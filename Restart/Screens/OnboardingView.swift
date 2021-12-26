//
//  OnboardingView.swift
//  Restart
//
//  Created by Ivan on 21/12/21.
//

import SwiftUI

struct OnboardingView: View {
  
  @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
  
  var body: some View {
    
    ZStack {
      Color("ColorBlue")
        .ignoresSafeArea()
      
      VStack(spacing: 20) {
        Spacer()
        // MARK: - HEADER
        VStack(spacing: 0) {
          Text("Share.")
            .font(.system(size: 60))
            .fontWeight(.heavy)
            .foregroundColor(.white)
          
          Text("""
               It's not how much we give but
               how much love we put into giving.
               """)
            .font(.title3)
            .fontWeight(.light)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 10)
        } //: HEADER
        
        // MARK: - CENTER
        ZStack {
          ZStack {
            Circle()
              .stroke( .white.opacity(0.2), lineWidth: 40 )
              .frame(width: 260, height: 206, alignment: .center)
            
            Circle()
              .stroke( .white.opacity(0.2), lineWidth: 80 )
              .frame(width: 260, height: 206, alignment: .center)
          }
          Image("character-1")
            .resizable()
            .scaledToFit()
        } //: CENTER
        Spacer()
        
        // MARK: - FOOTER
        ZStack {
          // 1. BACKGROUND
          Capsule()
            .fill(.white.opacity(0.2))
          Capsule()
            .fill(.white.opacity(0.2))
            .padding()
          
          // 2. CALL-TO-ACTION (STATIC)
          
          Text("Get Started")
            .font(.system(.title3, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.white)
            .offset(x: 20)
          
          // 3. CAPSULE (DYNAMIC WITH)
          
          HStack {
            Capsule()
              .fill(Color("ColorRed"))
              .frame(width: 80)
            
            Spacer()
          } //: HSTACK
          
          // 4. CIRCLE (DRAGGABLE)
          HStack {
            ZStack {
              Circle()
                .fill(Color("ColorRed"))
              Circle()
                .fill(.black.opacity(0.15))
                .padding(8)
              Image(systemName: "chevron.right.2")
                .font(.system(size: 24, weight: .bold))
            } //: ZSTACK
            .foregroundColor(.white)
            .frame(width: 80, height: 80, alignment: .center)
            .onTapGesture {
              self.isOnboardingViewActive = false
            }
            
            Spacer()
          } //: HSTACK
        } //: FOOTER
        .frame(height: 80, alignment: .center)
        .padding()
      }//: VSTACK
    } //: ZSTACK
  }
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView()
  }
}
