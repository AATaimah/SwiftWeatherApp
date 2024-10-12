//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Anas Taimah on 2024-10-11.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5){
                    Text(weather.name)
                        .bold().font(.title)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                
                
                VStack{
                    
                    HStack{
                        VStack(spacing: 20) {
                            let weatherIconMapping: [String: String] = [
                                    "Clear": "sun.max",
                                    "Clouds": "cloud",
                                    "Rain": "cloud.rain",
                                    "Drizzle": "cloud.drizzle",
                                    "Snow": "snow",
                                    "Thunderstorm": "cloud.bolt.rain",
                                    // Add more mappings as needed
                                ]

                                // Get the main weather condition
                                let weatherCondition = weather.weather[0].main

                                // Set the icon based on the weather condition
                                let weatherIcon = weatherIconMapping[weatherCondition] ?? "questionmark" // Default to a question mark if no match

                                Image(systemName: weatherIcon)
                                    .font(.system(size: 40))
                                
                                Text(weatherCondition)
                            
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(weather.main.feelsLike.roundDouble() + "°")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .padding()
                    }
                    
                    Spacer()
                        .frame(height: 80)
                    
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                        
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                    
                    
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather now")
                        .bold().padding(.bottom)
                    
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Min temp", value: (weather.main.tempMin.roundDouble() + ("°")))
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°"))
                        
                    }
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.663, saturation: 0.929, brightness: 0.246))
                .preferredColorScheme(.dark)
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.663, saturation: 0.929, brightness: 0.246))
        .preferredColorScheme(.dark)
        
    }
}

#Preview {
    WeatherView(weather: previewWeather)
}
