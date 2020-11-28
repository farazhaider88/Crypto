//
//  ContentView.swift
//  Crypto
//
//  Created by Faraz Haider on 28/11/2020.
//

import SwiftUI

struct GraphCoinView: View{
    let title : String
    let lineCoordinates :[CGFloat]
    
    
    var body : some View{
        LineChartController(lineCoordinates: lineCoordinates, inline: false)
            .padding(.leading)
            .navigationBarTitle(Text(title))
    }
}

struct BadgeSymbol: View {
    static let symbolColor = Color(red: 79.0 / 255, green: 79.0 / 255, blue: 191.0 / 255)

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = min(geometry.size.width, geometry.size.height)
                let height = width * 0.75
                let spacing = width * 0.030
                let middle = width / 2
                let topWidth = 0.226 * width
                let topHeight = 0.488 * height
                
                path.addLines([
                    CGPoint(x: middle, y: spacing),
                    CGPoint(x: middle - topWidth, y: topHeight - spacing),
                    CGPoint(x: middle, y: topHeight / 2 + spacing),
                    CGPoint(x: middle + topWidth, y: topHeight - spacing),
                    CGPoint(x: middle, y: spacing)
                ])
                
                path.move(to: CGPoint(x: middle, y: topHeight / 2 + spacing * 3))
                path.addLines([
                    CGPoint(x: middle - topWidth, y: topHeight + spacing),
                    CGPoint(x: spacing, y: height - spacing),
                    CGPoint(x: width - spacing, y: height - spacing),
                    CGPoint(x: middle + topWidth, y: topHeight + spacing),
                    CGPoint(x: middle, y: topHeight / 2 + spacing * 3)
                ])
            }
            .fill(Self.symbolColor)
        }
    }
}


struct Coin {
    let id, name, price, icon:String, lineCoordinates : [CGFloat]
}

struct ContentView: View {
    
    var rates:[Coin] = [
        Coin(id: "BTC", name: "Bitcoin", price: "9733.21", icon: "bitcoin",lineCoordinates:[5000,6000,7000,4000,2000,11000]),
        Coin(id: "LTC", name: "Litecoin", price: "78.70", icon: "litecoin",lineCoordinates:[300,200,90,1000,50,30]),
        Coin(id: "XIP", name: "Ripple", price: "0.30", icon: "ripple",lineCoordinates:[0.300,0.200,0.90,0.1000,0.50,0.30]),
        Coin(id: "TRX", name: "Tron", price: "0.02", icon: "tron",lineCoordinates:[0.100,0.1200,0.90,0.1000,0.50,0.30]),
        Coin(id: "ETH", name: "Etherium", price: "200.45", icon: "etherium",lineCoordinates:[300,600,190,100,530,350])
    ]
    
    var myWallet: [Coin] = [
        Coin(id: "BTC", name: "Bitcoin", price: "1000", icon: "bitcoin",lineCoordinates:[5000,6000,7000,4000,2000,11000]),
        Coin(id: "LTC", name: "Litecoin", price: "2000", icon: "litecoin",lineCoordinates:[300,200,90,1000,50,30]),
        Coin(id: "TRX", name: "Tron", price: "133.7", icon: "tron",lineCoordinates:[0.100,0.1200,0.90,0.1000,0.50,0.30])
    ]
    
    @State var is360 = false
    
    var body: some View {
  
        NavigationView{
            
            VStack{
                Button(action: {
                    self.is360.toggle()
                }){
                    BadgeSymbol().frame(width: 150, height: 150)
                        .rotation3DEffect(
                            .degrees(is360 ? 360 : 0),
                            axis: (x: 0.0, y: 1.0, z: 1.0))
                        .animation(.easeIn(duration: 0.7))
                }

                
                Text("Your crypto balance")
                Text("$31,1213.7")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                LineChartController(lineCoordinates:[3,2,6],inline: true).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,maxHeight: 150).padding()
                    
                List{
                    
                    Section(header: Text("My Wallet")){
                        
                        ForEach(myWallet, id:\.self.id) { coin  in
                            HStack{
                                Image(coin.icon).resizable().frame(width: 40, height: 40, alignment: .center)
                                
                                Text("\(coin.name) (\(coin.id))")
                                
                                Spacer()
                                
                                Text("$\(coin.price)").fontWeight(.bold)
                            }
                           
                        }
                        
                    }
                    
                    
                    
                    Section(header: Text("Current Prices")){
                        
                        ForEach(rates, id:\.self.id) { coin  in
                            
                            NavigationLink(
                                destination: GraphCoinView(title:coin.name,lineCoordinates: coin.lineCoordinates)){
                            HStack{
                                Image(coin.icon).resizable().frame(width: 40, height: 40, alignment: .center)
                                
                                Text("\(coin.name) (\(coin.id))")
                                
                                Spacer()
                                
                                Text("$\(coin.price)").fontWeight(.bold)
                            }
                        }
                           
                        }
                        
                    }
                    
                    
                    
                    
          
                }.listStyle(GroupedListStyle())
            }
       
            
            .navigationBarTitle("Dashboard").navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
