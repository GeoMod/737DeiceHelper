//
//  Model.swift
//  Deice737
//
//  Created by Daniel O'Leary on 2/7/21.
//

//import Combine
//
//class Eval: ObservableObject {
//
//	@Published var alert: AlertData?
//	@Published var showAlert = false
//
//	func subEvaluate(outsideAirTemp: Bool, fuelTemp: Bool, noVisibleMoisture: Bool, frostOutsideCSFF: Bool, upperWingClean: Bool) {
//		let notAllSatisfied = !outsideAirTemp || !fuelTemp || !noVisibleMoisture
//
//
//		if frostOutsideCSFF {
//			alert = AlertData(title: "Deicing Required", description: "Frost/Ice outside the Upper CSFF Area is never allowed.")
//			showAlert = true
//		} else if outsideAirTemp && fuelTemp && noVisibleMoisture {
//			alert = AlertData(title: "Good To Go!", description: "No Secondary Ice Inspection or Deicing required.")
//			showAlert = true
//		} else {
//			switch upperWingClean {
//				case true:
//					if notAllSatisfied {
//						alert = AlertData(title: "Secondary Ice Inspection Required", description: "Even if the top of the wing was clean, conduct inspection 15min prior to departure for any frost inside CSFF. If so, you MUST DEICE.")
//						showAlert = true
//					}
//				case false:
//					if notAllSatisfied {
//						alert = AlertData(title: "Deicing Required", description: "Frost/Ice inside CSFF area is not acceptable when all conditions are not met.")
//						showAlert = true
//					}
//			}
//		}
//	}
//}
