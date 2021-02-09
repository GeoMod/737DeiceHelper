//  ContentView.swift
//
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
					Text("Assumes ≤1/8in Frost Discovered Under Wing During Walk Around.")
						.fontWeight(.bold)
						.foregroundColor(.red)
						.minimumScaleFactor(0.8)
					HStack {
						Text("Is frost OUTSIDE the CSFF area on top of the wing?")
							.minimumScaleFactor(0.8)
						Spacer()
						Button(action: {
							frostOutsideCSFF = true
							evaluate()
						}, label: {
							Text(frostOutsideCSFF ? "Yes" : "No")
						})
						.frame(width: 100, height: 50)
						.background(RoundedRectangle(cornerRadius: 30).fill(frostOutsideCSFF ? Color.green : Color.red))
						.foregroundColor(.white)
					}
					VStack(alignment: .leading) {
						HStack {
							Image(systemName: "arrow.triangle.2.circlepath")
								.opacity(0.25)
								.shadow(color: Color.black.opacity(0.6), radius: 1, x: 2, y: 3)
								.padding(.trailing)
							Button(action: {
								upperWingClean.toggle()
							}, label: {
								Text(upperWingClean ? "Upper Wing Clean" : "Frost Inside CSFF")
									.foregroundColor(upperWingClean ? .green : .orange)
									.font(.system(size: 30, weight: .bold))
									.shadow(color: Color.black.opacity(0.6), radius: 7, x: 5, y: 5)

							})
							Spacer()
						}
					}
				}.padding(.top, 3)

				Group {
					HStack {
						Image(systemName:outsideAirTemp ? "thermometer.sun.fill" : "thermometer.snowflake")
							.renderingMode(.original)
							.font(.largeTitle)
						Text("Is OAT greater than or equal to +4ºC?")
							.minimumScaleFactor(0.8)
						Spacer()
						Button(action: {
							outsideAirTemp.toggle()
						}, label: {
							Text(outsideAirTemp ? "Yes" : "No")
						})
						.frame(width: 100, height: 50, alignment: .center)
						.background(RoundedRectangle(cornerRadius: 30).fill(outsideAirTemp ? Color.green : Color.red))
						.foregroundColor(.white)
					}
					HStack {
						Image(systemName:fuelTemp ? "airplane.circle.fill" : "drop.triangle.fill")
							.renderingMode(.original)
							.font(.largeTitle)
						Text("Is Fuel greater than or equal to -16ºC?")
							.minimumScaleFactor(0.8)
						Spacer()
						Button(action: {
							fuelTemp.toggle()
						}, label: {
							Text(fuelTemp ? "Yes" : "No")
						})
						.frame(width: 100, height: 50, alignment: .center)
						.background(RoundedRectangle(cornerRadius: 30).fill(fuelTemp ? Color.green : Color.red))
						.foregroundColor(.white)
					}
					HStack {
						Image(systemName:noVisibleMoisture ? "sun.max.fill" : "cloud.sleet.fill")
							.renderingMode(.original)
							.font(.largeTitle)
						Text("Is Visible Moisture Present?")
							.minimumScaleFactor(0.8)
						Spacer()
						Button(action: {
							noVisibleMoisture.toggle()
						}, label: {
							Text(noVisibleMoisture ? "No" : "Yes")
						})
						.frame(width: 100, height: 50, alignment: .center)
						.background(RoundedRectangle(cornerRadius: 30).fill(noVisibleMoisture ? Color.green : Color.red))
						.foregroundColor(.white)
					}
					Text("rain, snow, drizzle, or fog with less than 1mi visibility")
						.font(.footnote)
						.foregroundColor(.gray)
				}.padding([.top])


				VStack {
					Button(action: {
						evaluate()
					}, label: {
						ButtonView(title: "Evaluate", backgroundColor: .blue)
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
				Alert(title: Text(alert?.title ?? "Error Occurred"), message: Text(alert?.description ?? ""), dismissButton: .default(Text("OK"), action: {
					frostOutsideCSFF = false
				}))
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
		Group {
			ContentView()
//				.previewDevice("iPhone SE")
//			ContentView()
//				.previewDevice("iPhone 12 Pro Max")
		}
	}
}
