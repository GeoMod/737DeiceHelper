//
//  ComplicationController.swift
//  Deice737 WatchKit Extension
//
//  Created by Daniel O'Leary on 2/3/21.
//

import ClockKit
import SwiftUI


class ComplicationController: NSObject, CLKComplicationDataSource {

	let displayName = "Deice 737?"

	// MARK: - Complication Configuration
	func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
		let supportedComplications: [CLKComplicationFamily] = [.circularSmall, .graphicBezel, .graphicCorner, .graphicCircular, .modularSmall, .modularLarge, .utilitarianSmall, .utilitarianLarge, .utilitarianSmallFlat]

		let descriptors = [
			CLKComplicationDescriptor(identifier: "complication", displayName: displayName, supportedFamilies: supportedComplications)
			// Multiple complication support can be added here with more descriptors
		]
		// Call the handler with the currently supported complication descriptors
		handler(descriptors)
	}


	// MARK: - Timeline Configuration
	func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
		// Call the handler with the last entry date you can currently provide or nil if you can't support future timelines
		handler(nil)
	}

	func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
		// Call the handler with your desired behavior when the device is locked
		handler(.showOnLockScreen)
	}

	// MARK: - Timeline Population

	func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
		// Call the handler with the current timeline entry
		let now = Date()

		switch complication.family {
			case .circularSmall:
				let template = createTimelineEntry(for: complication)
				let entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: template)
				handler(entry)
			case .graphicBezel:
				let template = createTimelineEntry(for: complication)
				let entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: template)
				handler(entry)
			case .graphicCorner:
				let template = createTimelineEntry(for: complication)
				let entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: template)
				handler(entry)
			case .graphicCircular:
				let template = createTimelineEntry(for: complication)
				let entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: template)
				handler(entry)
			case .modularSmall:
				let template = createTimelineEntry(for: complication)
				let entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: template)
				handler(entry)
			case .modularLarge:
				let template = createTimelineEntry(for: complication)
				let entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: template)
				handler(entry)
			case .utilitarianSmall:
				let template = createTimelineEntry(for: complication)
				let entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: template)
				handler(entry)
			case .utilitarianSmallFlat:
				let template = createTimelineEntry(for: complication)
				let entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: template)
				handler(entry)
			case .utilitarianLarge:
				let template = createTimelineEntry(for: complication)
				let entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: template)
				handler(entry)
			default:
				handler(nil)
		}
	}

	func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
		// Call the handler with the timeline entries after the given date
		handler(nil)
	}

	private func createTimelineEntry(for complication: CLKComplication) -> CLKComplicationTemplate {

		switch complication.family {
			case .circularSmall:
				let image = UIImage(named: "Complication/Circular")!
				let circularSmall = CLKComplicationTemplateCircularSmallSimpleImage(imageProvider: CLKImageProvider(onePieceImage: image))
				return circularSmall

			case .graphicBezel:
				let image = UIImage(named: "Complication/Graphic Bezel")!
				let fullColorImage = CLKFullColorImageProvider(fullColorImage: image)
				let graphicCircularImageTemplate = CLKComplicationTemplateGraphicCircularImage(imageProvider: fullColorImage)
				let text = CLKSimpleTextProvider(text: displayName)
				let graphicBezelTemplate = CLKComplicationTemplateGraphicBezelCircularText(circularTemplate: graphicCircularImageTemplate, textProvider: text)
				return graphicBezelTemplate

			case .graphicCorner:
				let image = UIImage(named: "Complication/Graphic Corner")!
				let fullColorImageProvider = CLKFullColorImageProvider(fullColorImage: image)
				let text = CLKSimpleTextProvider(text: displayName)
				let graphicCorner = CLKComplicationTemplateGraphicCornerTextImage(textProvider: text, imageProvider: fullColorImageProvider)
				return graphicCorner

			case .graphicCircular:
				return CLKComplicationTemplateGraphicCircularView(GraphicCircular())

			case .modularSmall:
				let image = UIImage(named: "Complication/Modular")!
				let modularSmall = CLKComplicationTemplateModularSmallSimpleImage(imageProvider: CLKImageProvider(onePieceImage: image))
				return modularSmall

			case .modularLarge:
				let header = CLKSimpleTextProvider(text: displayName)
				let body1 = CLKSimpleTextProvider(text: "Safety Is No Accident!")
				let modularLarge = CLKComplicationTemplateModularLargeStandardBody(headerTextProvider: header, body1TextProvider: body1)
				return modularLarge

			case .utilitarianSmall:
				let image = UIImage(named: "Complication/Utilitarian")!
				let imageProvider = CLKImageProvider(onePieceImage: image)
				let utilitarianSmall = CLKComplicationTemplateUtilitarianSmallSquare(imageProvider: imageProvider)
				return utilitarianSmall

			case .utilitarianSmallFlat:
				let text = CLKSimpleTextProvider(text: displayName, shortText: "737")
				let utilitarianSmallFalt = CLKComplicationTemplateUtilitarianSmallFlat(textProvider: text)
				return utilitarianSmallFalt

			case .utilitarianLarge:
				let text = CLKSimpleTextProvider(text: displayName, shortText: "737")
				let utilitarianLarge = CLKComplicationTemplateUtilitarianLargeFlat(textProvider: text)
				return utilitarianLarge

			default:
				let image = UIImage(named: "Complication/Circular")!
				let imageProvider = CLKImageProvider(onePieceImage: image)
				let circularSmall = CLKComplicationTemplateCircularSmallSimpleImage(imageProvider: imageProvider )
				return circularSmall
		}
	}

	// MARK: - Templates for Selection and Lockscreen Display
	// Since Templates and Timeline entries are the same, the complication only launches the watchOS App, therefore `createTimelineEntry(for:)` is used again here.
	func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
		// This method will be called once per supported complication, and the results will be cached
		switch complication.family {
			case .circularSmall:
				handler(createTimelineEntry(for: complication))
			case .graphicBezel:
				handler(createTimelineEntry(for: complication))
			case .graphicCorner:
				handler(createTimelineEntry(for: complication))
			case .modularSmall:
				handler(createTimelineEntry(for: complication))
			case .modularLarge:
				handler(createTimelineEntry(for: complication))
			case .utilitarianSmall:
				handler(createTimelineEntry(for: complication))
			case .utilitarianSmallFlat:
				handler(createTimelineEntry(for: complication))
			case .utilitarianLarge:
				handler(createTimelineEntry(for: complication))
			default:
				handler(nil)
		}
	}
}


struct GraphicCircular: View {
	var body: some View {
		Image("Complication/Graphic Bezel")
	}
}

