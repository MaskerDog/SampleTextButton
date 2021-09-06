//
//  ContentView.swift
//  SampleTextButton
//
//  Created by npc on 2021/09/06.
//

import SwiftUI

extension Color {
    init(hex: String) {
        // スペースや記号などを取り除く
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgbValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xff0000) >> 16)
        let green = Double((rgbValue & 0xff00) >> 8)
        let blue = Double(rgbValue & 0xff)
        
        self.init(
            .sRGB,
            red: red / 0xff,
            green: green / 0xff,
            blue: blue / 0xff,
            opacity: 1.0000
        )
    }
}

struct ContentView: View {
    
    private func reverseMaskPath(_ rect: CGRect) -> Path {
        
        // 逆マスク範囲
        let radius = rect.size.width / 2
        let path = UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath
        
        // 周囲
        var shape = Path(CGRect(origin: .zero, size: UIScreen.main.bounds.size))
        // 逆マスク範囲を追加
        shape.addPath(Path(path))
        return shape
    }
    
    var body: some View {
        VStack {
            Text("ボタンのレイアウト集")
                .padding()
                .frame(maxWidth: .infinity)
            
            Button(action: {}, label: {
                Text("シンプルなボタン")
                Text("ボタンの文字色はアクセントカラーで表示される")
                Text("指定がなければHStackになる")
            })
            .padding()
            .border(Color.black)
            Button(action: {}, label: {
                VStack {
                    Text("シンプルなボタン")
                    Text("VStack。\n改行は\\nで行う。")
                }
            })
            .padding()
            .border(Color.black)
            
            
            Button(action: {}, label: {
                Text("サンプルボタン")
                    
                    .font(.custom("HiraMaruProN-W4", size: 15))
                    .frame(width: 150, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                
            })
            
            Spacer().frame(height: 10)
            
            Button(action: {}, label: {
                Text("まる")
                    // 丸くするには、高さと幅を同じにして、その半分で
                    // radiusをかける
                    .font(.custom("HiraMaruProN-W4", size: 20))
                    .frame(width: 70, height: 70)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(35)
            })
            
            Spacer().frame(height: 10)
            
            Group {
                Button(action: {}, label: {
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color(hex: "#5f7429"))
                            .frame(width: 220, height: 50)
                            // マスクかけないと重なった部分が気持ち悪い
                            .mask(
                                reverseMaskPath(CGRect(x: -0.2, y: .zero, width: 60, height: 50))
                                    .fill(style: FillStyle(eoFill: true))
                            )
                        
                        
                        Label(
                            title: {
                                Text("よくある感じの１")
                                    .font(.custom("HiraMaruProN-W4", size: 17))
                                    .foregroundColor(Color(hex: "#f7fbec"))
                            },
                            icon: {
                                Image(systemName: "hand.thumbsup.fill")
                                    .font(.title2)
                                    .foregroundColor(Color(hex: "#f7fbec"))
                                    .frame(width: 60, height: 50)
                                    .background(Color(hex: "#799233"))
                                    .cornerRadius(25)
                                    
                                
                            })
                    }
                        
                })
                
                
                // labelを使わない（右はできない）
                Button(action: {}, label: {
                    ZStack(alignment: .trailing) {
                        Capsule()
                            .fill(Color(hex: "#e6f3c4"))
                            .frame(width: 220, height: 50)
                            // マスクかけないと重なった部分が気持ち悪い
                            .mask(
                                reverseMaskPath(CGRect(x: 220 - 50, y: .zero, width: 50, height: 50))
                                    .fill(style: FillStyle(eoFill: true))
                            )
                        
                        HStack {
                            Text("よくある感じの２")
                                .font(.custom("HiraMaruProN-W4", size: 17))
                                .foregroundColor(Color(hex: "#5f7429"))
                            Image(systemName: "hand.thumbsup.fill")
                                
                                .font(.title2)
                                .foregroundColor(Color(hex: "#f7fbec"))
                                .frame(width: 50, height: 50)
                                .background(Color(hex: "#bee064"))
                                .clipShape(Circle())
                        }
                        
                    }
                })
                
                Spacer().frame(height: 10)
                
                Button(action: {}, label: {
                    // 左下から右上にグラデーション
                    let startPoint = UnitPoint(x: 0, y: 1)
                    let endPoint = UnitPoint(x: 1, y: 0)
                    
                    Text("Gradient")
                        .fontWeight(.heavy)
                        .frame(width: 150, height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [
                                                                        Color(hex: "#f7e9fb"),
                                                                        Color(hex: "#e2b4f0"),
                                                                        Color(hex: "#4ddab9")]),
                                                   startPoint: startPoint,
                                                   endPoint: endPoint))
                        .foregroundColor(Color(hex: "#ffffff"))
                        .cornerRadius(25)
                    
                    
                })
                
                Spacer().frame(height: 10)
                
                // ZStackを使わないパターン
                Button(action: {}, label: {
                    Text("Circle")
                        .frame(width: 70, height: 70)
                        .foregroundColor(Color(hex: "#3d7a2b"))
                        .background(Circle()
                                        .strokeBorder(
                                            AngularGradient(gradient: Gradient(colors: [
                                                                                Color(hex: "#f7e9fb"),
                                                                                Color(hex: "#e2b4f0"),
                                                                                Color(hex: "#4ddab9"),
                                                                                Color(hex: "#e2b4f0"),
                                                                                Color(hex: "#f7e9fb"),]),
                                                            center: .center,
                                                            startAngle: .degrees(135),
                                                            endAngle: .degrees(495)),
                                            lineWidth: 3
                                        )
                                        .background(Circle().fill(Color(hex: "f8f9fe")))
                                    
                        )
                    
                })
                
                Spacer().frame(height: 10)
                
                Button(action: {}, label: {
                    Text("影付きのボタン")
                        
                        .font(.custom("HiraMaruProN-W4", size: 15))
                        .frame(width: 150, height: 50)
                        .background(Color(hex: "#70dc50"))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .shadow(color: Color(hex: "b8c8bc"), radius: 5.0, x: 0.0, y: 5.0)
                })
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
