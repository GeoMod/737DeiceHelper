//
//  ContentView.swift
//  Deice737 WatchKit Extension
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
		ScrollView {
			VStack {
				Text("Assumes ≤1/8in Frost Under Wing")
					.foregroundColor(.red)
					.fontWeight(.medium)

				Toggle("Upper wing frost outside CSFF area?", isOn: $frostOutsideCSFF)
					.minimumScaleFactor(0.9)
					.lineLimit(2)
				Toggle("Upper Wing Clean?", isOn: $upperWingClean)
				Divider()

				Text(upperWingClean ? "Upper Wing Clean" : "Frost Inside CSFF")
					.foregroundColor(upperWingClean ? .green : .blue)

				Toggle("OAT ≥ 4ºC", isOn: $outsideAirTemp)
					.padding(.bottom, 2)
				Toggle("Fuel ≥ -16ºC", isOn: $fuelTemp)
					.padding(.bottom, 2)
				Toggle("Visible Moisture", isOn: $noVisibleMoisture)
				Text("rain, snow, drizzle, or fog with less than 1mi visibility")
					.font(.footnote)
					.foregroundColor(.gray)

				Button("Evaluate") {
					// evaluate and present alert
					evaluate()
				}
			}.padding(.trailing, 2)
			.navigationTitle("Deice 737?")

			.alert(isPresented: $showAlert, content: {
				Alert(title: Text(alert?.title ?? "Error Occurred"), message: Text(alert?.description ?? "💺"), dismissButton: .default(Text("OK")))
			})
		}
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
						alert = AlertData(title: "Secondary Ice Inspection Required", description: "Even if the top of the wing was clean, conduct inspection 15min prior to departure for any frost inside CSFF. If so, you MUST DEICE.")
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
