//
//  CityBarCodeView.swift
//  Weather
//
//  Created by Jan Hovland on 06/04/2021.
//

import SwiftUI

struct cityBarCodeView: View {
    @Binding var datas: [Double]
    
    var body: some View {
        GeometryReader { outer in
            HStack (alignment: .bottom) {
                ForEach (datas.indices) { i in
                    VStack {
                        Spacer()
                        Text(String(datas[i]))
                            .font(.system(size: 10, weight: .regular))
                        Rectangle()
                            .fill(Color(red: 159/255,
                                        green: 207/255,
                                        blue: 255/255,
                                        opacity: 1.0))
                            .frame(width: CGFloat(outer.size.width / 18) , height: CGFloat(10 * datas[i]))
                        
                    }
                }
                .offset(x: CGFloat(outer.size.width / 15), y: CGFloat(12))
            }
            .padding(.bottom, 20)
            .padding(.trailing,20)
        }
        .padding(.bottom, 20)
        .padding(.trailing,20)
    }
}
