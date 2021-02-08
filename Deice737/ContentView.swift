//
//  ContentView.swift
//  Deice737
//
//  Created by Daniel O'Leary on 2/3/21.
//

import SwiftUI

struct ContentView: View {

	@State var alert: AlertData?
	@State private var showAlert = false

	@State private var frostOutsideCSFF 	= false
	@State private var upperWingClean 		= false
	@State private var noVisibleMoisture 	= false
	@State private var outsideAirTemp 		= false
	@State private var fuelTemp 			= false


	var body: some View {
		NavigationView {
			VStack {
				Group {
					Text("Assumes ≤1/8in Frost Under Wing")
						.foregroundColor(.red)
						.fontWeight(.bold)
					Toggle("Upper wing frost outside CSFF area?", isOn: $frostOutsideCSFF)
						.minimumScaleFactor(0.9)
						.lineLimit(2)
					Toggle("Upper Wing Clean?", isOn: $upperWingClean)
				}.padding(.top)

				Divider()

				Group {
					Text(upperWingClean ? "Upper Wing Clean" : "Frost Inside CSFF")
						.fontWeight(.bold)
						.foregroundColor(upperWingClean ? .green : .orange)
					HStack {
						Image(systemName:outsideAirTemp ? "thermometer.sun.fill" : "thermometer.snowflake")
							.renderingMode(.original)
							.font(.largeTitle)
						Toggle("OAT ≥ 4ºC", isOn: $outsideAirTemp)
					}
					HStack {
						Image(systemName:fuelTemp ? "airplane.circle.fill" : "drop.triangle.fill")
							.renderingMode(.original)
							.font(.largeTitle)
						Toggle("Fuel ≥ -16ºC", isOn: $fuelTemp)
					}
					HStack {
						Image(systemName:noVisibleMoisture ? "cloud.sleet.fill" : "cloud.fill")
							.renderingMode(.original)
							.font(.largeTitle)
						Toggle("Visible Moisture", isOn: $noVisibleMoisture)
					}
					Text("rain, snow, drizzle, or fog with less than 1mi visibility")
						.font(.footnote)
						.foregroundColor(.gray)
				}

				Spacer()

				HStack {
					Button(action: {
						resetValues()
					}, label: {
						ButtonView(title: "Reset", backgroundColor: .red)
					})

					Button(action: {
						evaluate()
					}, label: {
						ButtonView(title: "Evaluate", backgroundColor: .blue)
					})
				}
				Spacer()
			}
			.padding([.leading, .trailing])
			.font(.title2)

			// Seahawks Blue background color.
			.background(Color("BackgroundColor").edgesIgnoringSafeArea(.bottom)
							.opacity(0.7)
							.cornerRadius(30)
							.padding([.leading, .trailing], 6)
			)
			.navigationBarTitle(Text("Deice 737?"))

			.background(Image("clouds").resizable().edgesIgnoringSafeArea(.all))

			.alert(isPresented: $showAlert, content: {
				Alert(title: Text(alert?.title ?? "Error Occurred"), message: Text(alert?.description ?? "💺"), dismissButton: .default(Text("OK")))
			})

		}.colorScheme(.dark)
	}

	private func resetValues() {
		frostOutsideCSFF 	= false
		upperWingClean 		= false
		noVisibleMoisture 	= false
		outsideAirTemp 		= false
		fuelTemp 			= false
	}


	private func evaluate() {
		let notAllSatisfied = !outsideAirTemp || !fuelTemp || !noVisibleMoisture

		if frostOutsideCSFF {
			alert = AlertData(title: "Deicing Required", description: "Frost/Ice outside the Upper CSFF Area is never allowed.")
			showAlert = true
		} else if outsideAirTemp && fuelTemp && noVisibleMoisture {
			alert = AlertData(title: "Good To Go!", description: "No Secondary Ice Inspection or Deicing required.")
			showAlert = true
		} else {
			switch upperWingClean {
				case true:
					if notAllSatisfied {
						alert = AlertData(title: "Secondary Ice Inspection Required", description: "Even if the top of the wing was clean, conduct inspection 15min prior to departure for any frost inside CSFF area. If so, you MUST DEICE.")
						showAlert = true
					}
				case false:
					if notAllSatisfied {
						alert = AlertData(title: "Deicing Required", description: "Frost/Ice inside CSFF area is not acceptable when all conditions are not met.")
						showAlert = true
					}
			}
		}
	}


}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
