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
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region, annotationItems: userLocations) { location in
                MapPin(coordinate: location.coordinate)
            }
        }
        .padding()
        .onAppear {
            focusMapOnUserLocation()
        }
    }

    
    private func focusMapOnUserLocation() {
        self.userLocations = [UserLocation(coordinate: region.center)]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
