//  ContentView.swift
//
//  Deice737
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
		VStack {
			Text("CSFF Evaluator")
				.font(.title)
				.fontWeight(.bold)
			Spacer()
			Group {
				Text("Assumes ≤1/8in Frost Discovered Under Wing During Walk Around.")
					.fontWeight(.bold)
					.foregroundColor(.red)
					.minimumScaleFactor(0.6)
					.lineLimit(2)

				HStack {
					Text("Is frost OUTSIDE the CSFF area on top of the wing?")
						.minimumScaleFactor(0.7)
						.lineLimit(2)
					Spacer()
					Button(action: {
						frostOutsideCSFF = true
						evaluate()
					}, label: {
						YesNoButtonView(title: frostOutsideCSFF ? "Yes" : "No", condition: frostOutsideCSFF)
					})
				}.padding(.top, 3)

				Picker("Upper Wing Clean?", selection: $upperWingCondition) {
					Text("Frost Inside CSFF")
						.fontWeight(.bold)
						.tag(UpperWingCondition.contaminated)
					Text("Upper Wing Clean")
						.tag(UpperWingCondition.clean)
				}.pickerStyle(SegmentedPickerStyle())
				.padding(.top)
			}

			// OAT, Fuel Temp, Precip Conditions
			ThreeConditionsView

			Spacer()

			VStack {
				Button(action: {
					evaluate()
				}, label: {
					EvaluateButtonView(title: "Evaluate", backgroundColor: .blue)
				})
				Button(action: {
					resetValues()
				}, label: {
					Text("Reset")
						.foregroundColor(.red)
				})
			}
			Spacer()
		}
		.font(.title2)
		.padding([.leading, .trailing], 2)
		.colorScheme(.dark)

		.background(
			// Seahawks Blue background color.
			Color("BackgroundColor").edgesIgnoringSafeArea(.all)
		)

		.alert(isPresented: $showAlert, content: {
			Alert(title: Text(alert?.title ?? "Error Occurred"), message: Text(alert?.description ?? ""), dismissButton: .default(Text("OK"), action: {
				frostOutsideCSFF = false
			}))
		})


	}

	private var ThreeConditionsView: some View {
		Group {

			HStack {
				Image(systemName:outsideAirTemp ? "thermometer.sun.fill" : "thermometer.snowflake")
					.renderingMode(.original)
					.font(.largeTitle)
				Text("Is OAT greater than or equal to +4ºC?")
					.minimumScaleFactor(0.8)
					.lineLimit(2)
				Spacer()
				Button(action: {
					outsideAirTemp.toggle()
				}, label: {
					YesNoButtonView(title: outsideAirTemp ? "Yes" : "No", condition: outsideAirTemp)
				})
			}
			HStack {
				Image(systemName:fuelTemp ? "airplane.circle.fill" : "drop.triangle.fill")
					.renderingMode(.original)
					.font(.largeTitle)
				Text("Is Fuel greater than or equal to -16ºC?")
					.minimumScaleFactor(0.8)
					.lineLimit(2)
				Spacer()
				Button(action: {
					fuelTemp.toggle()
				}, label: {
					YesNoButtonView(title: fuelTemp ? "Yes" : "No", condition: fuelTemp)
				})
			}
			HStack {
				Image(systemName:noVisibleMoisture ? "sun.max.fill" : "cloud.sleet.fill")
					.renderingMode(.original)
					.font(.largeTitle)
				Text("Is Visible Moisture Present?")
					.minimumScaleFactor(0.7)
					.lineLimit(2)
				Spacer()
				Button(action: {
					noVisibleMoisture.toggle()
				}, label: {
					YesNoButtonView(title: noVisibleMoisture ? "No" : "Yes", condition: noVisibleMoisture)
				})
			}
			Text("rain, snow, drizzle, or fog with less than 1mi visibility")
				.font(.footnote)
				.foregroundColor(.gray)
				.minimumScaleFactor(0.8)
				.lineLimit(2)
		}.padding(.top)
	}

	private func resetValues() {
		frostOutsideCSFF 	= false
		noVisibleMoisture 	= false
		outsideAirTemp 		= false
		fuelTemp 			= false
		upperWingCondition 	= .contaminated
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
						alert = AlertData(title: "Secondary Ice Inspection Required", description: "Even if the top of the wing was clean, conduct inspection 15min prior to departure for any frost inside CSFF area. If so, you MUST DEICE.")
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
		Group {
//			ContentView()
//				.previewDevice("iPhone SE")
			ContentView()
				.previewDevice("iPhone 12 Pro")
//			ContentView()
//				.previewDevice("iPhone SE (1st generation)")
		}
	}
}
