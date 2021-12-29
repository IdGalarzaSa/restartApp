//
//  OnboardingView.swift
//  Restart
//
//  Created by Ivan on 21/12/21.
//

import SwiftUI

struct OnboardingView: View {
  
  @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
  
  @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
  @State private var buttonOffset: CGFloat = 0
  @State private var isAnimating: Bool = false
  @State private var imageOffset: CGSize = .zero
  @State private var indicatorOpacity: Double = 1.0
  @State private var textTitle = "Share."
  
  var body: some View {
    
    ZStack {
      Color("ColorBlue")
        .ignoresSafeArea(.all, edges: .all)
      
      VStack(spacing: 20) {
        // MARK: - HEADER
        Spacer()
        VStack(spacing: 0) {
          Text(textTitle)
            .font(.system(size: 60))
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .transition(.opacity)
            .id(textTitle)
          
          Text("""
               It's not how much we give but
               how much love we put into giving.
               """)
            .font(.title3)
            .fontWeight(.light)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 10)
        }
        .opacity(isAnimating ? 1: 0)
        .offset(y: isAnimating ? 0 : -40)
        .animation(.easeOut(duration: 1), value: isAnimating)
        //: HEADER
        
        // MARK: - CENTER
        ZStack {
          CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
            .offset(x: imageOffset.width * -1)
            .blur(radius: abs(imageOffset.width / 5))
            .animation(Animation.easeOut(duration: 1), value: imageOffset)
          
          
          Image("character-1")
            .resizable()
            .scaledToFit()
            .opacity(isAnimating ? 1 : 0)
            .animation(.easeOut(duration: 1), value: isAnimating) // Animació de la imagen
            .offset(x: imageOffset.width, y: 0) // El rango permitido para mover segun el drag
            .rotationEffect(.degrees(Double(imageOffset.width / 20))) // La rotación de la imagen
            .gesture(
              DragGesture()
                .onChanged({ gesture in
                  // abs -> saca el valor absoluto. Ej: de -150 es 150. Siempre un número positivo
                  if abs(gesture.translation.width) <= 150 {
                    imageOffset = gesture.translation // gesture translation nso retorna un CGSize
                    
                    withAnimation(.linear(duration: 0.25), {
                      indicatorOpacity = 0
                      textTitle = "Given."
                    })
                  }
                })
                .onEnded({ _ in
                  imageOffset = .zero
                  
                  withAnimation(.linear(duration: 0.25), {
                    indicatorOpacity = 1.0
                    textTitle = "Share."
                  })
                })
            ).animation(.easeOut(duration: 1), value: imageOffset)
        }
        .overlay(
          Image(systemName: "arrow.left.and.right.circle")
            .font(.system(size: 44, weight: .ultraLight))
            .foregroundColor(.white)
            .offset(x: isAnimating ? -15 : 15, y:20)
            .animation(Animation.linear(duration: 2).repeatForever(), value: isAnimating)
            .opacity(isAnimating ? 1 : 0)
            .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
            .opacity(indicatorOpacity)
          , alignment: .bottom
        )
        //: CENTER
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
              .frame(width: buttonOffset + 80)
            
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
            .offset(x: buttonOffset)
            .gesture(
              DragGesture()
                .onChanged({ gesture in
                  let currentPosition = gesture.translation.width
                  if currentPosition > 80 && buttonOffset < buttonWidth - 80 {
                    buttonOffset = gesture.translation.width
                  }
                })
                .onEnded({ _ in
                  withAnimation(Animation.easeOut(duration: 1)){
                    if buttonOffset > buttonWidth / 2 {
                      playSound(sound: "chimeup", type: "mp3")
                      buttonOffset = buttonWidth - 80
                      isOnboardingViewActive = false
                    } else {
                      buttonOffset = 0
                    }
                  }
                })
            )
            
            Spacer()
          } //: HSTACK
        } //: FOOTER
        .frame(width: buttonWidth, height: 80, alignment: .center)
        .padding()
        .opacity(isAnimating ? 1 : 0)
        .offset(y: isAnimating ? 0 : 40)
        .animation(.easeOut(duration: 1), value: isAnimating)
      }//: VSTACK
    }
    .onAppear(perform: {
      isAnimating = true
    })
    .preferredColorScheme(.dark)
    //: ZSTACK
  }
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView()
      .previewDevice("iPhone 13")
  }
}
