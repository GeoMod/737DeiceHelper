//
//  ContentView.swift
//  Deice737 WatchKit Extension
//
//  Created by Daniel O'Leary on 2/3/21.
//

import SwiftUI

struct ContentView: View {

	enum UpperWingCondition {
		case contaminated
		case clean
	}

	@State var alert: AlertData?
	@State private var showAlert = false

	@State private var upperWingCondition 	= UpperWingCondition.contaminated

	@State private var frostOutsideCSFF 	= false
	@State private var noVisibleMoisture 	= false
	@State private var outsideAirTemp 		= false
	@State private var fuelTemp 			= false
	

	var body: some View {
		ScrollView {
			VStack {
				Text("Assumes ≤1/8in Frost Under Wing")
					.foregroundColor(.red)
					.fontWeight(.medium)
					.minimumScaleFactor(0.7)
					.lineLimit(4)

				Toggle("Frost OUTSIDE the CSFF area.", isOn: $frostOutsideCSFF)
					.minimumScaleFactor(0.7)
					.lineLimit(3)
				Picker("Upper Wing Condition", selection: $upperWingCondition) {
					Text("Frost Inside CSFF")
						.tag(UpperWingCondition.contaminated)
					Text("Upper Wing Clean")
						.tag(UpperWingCondition.clean)
				}
				.pickerStyle(WheelPickerStyle())
				.labelsHidden()

				Divider()

				Toggle("OAT ≥ 4ºC", isOn: $outsideAirTemp)
					.padding(.bottom, 2)
				Toggle("Fuel ≥ -16ºC", isOn: $fuelTemp)
					.padding(.bottom, 2)
				Toggle("Visible Moisture", isOn: $noVisibleMoisture)
				Text("rain, snow, drizzle, or fog with less than 1mi visibility")
					.minimumScaleFactor(0.8)
					.lineLimit(2)
					.font(.footnote)
					.foregroundColor(.gray)

				Button("Evaluate") {
					// evaluate and present alert
					evaluate()
				}
			}.padding(.trailing, 2)
			.navigationTitle("737 CSFF")

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
			switch upperWingCondition {
				case .clean:
					if notAllSatisfied {
						alert = AlertData(title: "Secondary Ice Inspection Required", description: "Even if the top of the wing was clean, conduct inspection 15min prior to departure for any frost inside CSFF. If so, you MUST DEICE.")
						showAlert = true
					}
				case .contaminated:
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
