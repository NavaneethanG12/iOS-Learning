//
//  Bullseye.swift
//  SwifyUIBeginnerLearning
//
//  Created by navaneeth-pt4855 on 29/06/22.
//

import SwiftUI

struct Bullseye: View {
    @State var target: Int = 89
    @State var sliderValue: CGFloat = 40
    @State var score: Int = 999
    @State var rounds: Int = 3
    
    init() {
        
    }
    
    var body: some View {
        VStack(spacing: 4){
            Text("🎯🎯🎯Put the bullseye as close as you can".uppercased())
                .titleText(.black,13)
            Text("\(target)")
                .titleText(.red, 25)
            HStack(spacing: 10){
                Text("\(1)")
                    .titleText(.red, 15)
                Slider(value: $sliderValue, in: 1.0...100.0)
                    .tint(.red)
                Text("\(100)")
                    .titleText(.red, 15)
            }
            Spacer()
            
            HStack {
                Spacer()
                VStack{
                    Text("Score".uppercased())
                        .titleText(.black, 15)
                    Text("\(score)")
                        .titleText(.black, 20)
                        .makebutton(.white, strokeColor: .gray, textColor: .black)
                }
                Spacer()
                Button {
                    
                } label: {
                    Text("Hit Me")
                        .makebutton(.purple, strokeColor: .white)
                    
                }
                Spacer()
                VStack{
                    Text("Round".uppercased())
                        .titleText(.black, 15)
                    Text("\(rounds)")
                        .titleText(.black, 20)
                        .makebutton(.white, strokeColor: .gray, textColor: .black)
                }
                Spacer()
            }
            .frame(width: .infinity, height: 80, alignment: .center)

            Spacer()
            
        }
    }
}

struct Bullseye_Previews: PreviewProvider {
    static var previews: some View {
        Bullseye()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}

struct TitleTextModifier: ViewModifier{
   
    var textColor: Color
    var size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: .bold, design: .default))
            .foregroundColor(textColor)
        
    }
    
}

struct ButtonModifier: ViewModifier{
    
    var btnColor: Color
    var strokeColor: Color
    var textColor: Color
    
    func body(content: Content) -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 19)
                .fill(btnColor)
                .frame(width: 100, height: 52, alignment: .center)
                .shadow(color: btnColor.opacity(0.5), radius: 5, x: 5, y: 5)
                .overlay{
                    RoundedRectangle(cornerRadius: 19)
                        .strokeBorder(strokeColor, lineWidth: 2, antialiased: true)
                        .frame(width: 100, height: 52, alignment: .center)
                }
            content
                .foregroundColor(textColor)
                
        }
        
    }
}


extension View {
    
    func titleText(_ color: Color,_ size: CGFloat)-> some View{
        return self.modifier(TitleTextModifier(textColor: color, size: size))
    }
    
    func makebutton(_ color: Color, strokeColor: Color, textColor: Color = .white) -> some View{
        self.modifier(ButtonModifier(btnColor: color, strokeColor: strokeColor, textColor: textColor))
    }
    
}

