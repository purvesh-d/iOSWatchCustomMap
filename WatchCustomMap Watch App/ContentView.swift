//
//  ContentView.swift
//  WatchCustomMap Watch App
//
//  Created by Purvesh Dodiya on 01/06/23.
//

import SwiftUI
import MapKit

struct UserLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 23.0284576, longitude: 72.499382),
        span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
    )
    
    @State var userLocations: [UserLocation] = []
    @State var totalLocations: [UserLocation] = []
    
    var body: some View {
        VStack {
            //   Map(coordinateRegion: $region)
            Map(coordinateRegion: $region, annotationItems: userLocations) { location in
                //MapMarker(coordinate: location.coordinate, tint: .red)
                
                MapAnnotation(coordinate: location.coordinate) {
                    //                    Image("icon_red_dot")
                    //                        .foregroundColor(.blue)
                    //                        .frame(height: 0)
                    Color.red.frame(width: 5, height: 5)
                    
                }
            }
        }
        .padding()
        .onAppear {
            generateCoordinator()
        }
    }
    
    
    private func generateCoordinator() {
        self.totalLocations = [UserLocation(coordinate: region.center)]
        let delta = 0.0001
        let totalIterations = 2000 // Total number of locations to add
        let delay = 0.0 // Delay in seconds
        
        for i in 1...totalIterations {
            // DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * delay) {
            let previousLocation = self.totalLocations[i - 1].coordinate
            if i < 200 || (i > 850 && i < 1100)  {
                let newCoordinate = CLLocationCoordinate2D(
                    latitude: previousLocation.latitude ,
                    longitude: previousLocation.longitude + delta
                )
                let userLocation = UserLocation(coordinate: newCoordinate)
                self.totalLocations.append(userLocation)
            } else if (i < 400 || (i > 850 && i < 1300)) {
                let newCoordinate = CLLocationCoordinate2D(
                    latitude: previousLocation.latitude + delta,
                    longitude: previousLocation.longitude
                )
                let userLocation = UserLocation(coordinate: newCoordinate)
                self.totalLocations.append(userLocation)
            } else if i < 600 || (i > 850 && i < 1500){
                let newCoordinate = CLLocationCoordinate2D(
                    latitude: previousLocation.latitude ,
                    longitude: previousLocation.longitude - delta
                )
                let userLocation = UserLocation(coordinate: newCoordinate)
                self.totalLocations.append(userLocation)
            } else {
                let newCoordinate = CLLocationCoordinate2D(
                    latitude: previousLocation.latitude - delta,
                    longitude: previousLocation.longitude
                )
                let userLocation = UserLocation(coordinate: newCoordinate)
                self.totalLocations.append(userLocation)
            }
            
        }
        userLocations = totalLocations
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
