//
//  ComplicationController.swift
//  Deice737 WatchKit Extension
//
//  Created by Daniel O'Leary on 2/3/21.
//

import ClockKit
import SwiftUI


class ComplicationController: NSObject, CLKComplicationDataSource {

	// MARK: - Complication Configuration

	func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
		let supportedComplications: [CLKComplicationFamily] = [.circularSmall, .graphicBezel, .graphicCorner, .graphicCircular, .modularSmall, .modularLarge, .utilitarianSmall, .utilitarianLarge,.utilitarianSmallFlat]

		let descriptors = [
			CLKComplicationDescriptor(identifier: "complication", displayName: "SecondaryIceInspection", supportedFamilies: supportedComplications)
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
//		let supportedComplications: [CLKComplicationFamily] = [.circularSmall, .graphicBezel, .graphicCorner, .graphicCircular, .modularSmall, .modularLarge, .utilitarianSmall, .utilitarianLarge,.utilitarianSmallFlat]
		let now = Date()

		switch complication.family {
			case .circularSmall:
				let template = createTemplate(for: complication)
				let entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: template)
				handler(entry)
			case .graphicBezel:
				let template = createTemplate(for: complication)
				let entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: template)
				handler(entry)
			case .graphicCorner:
				let template = createTemplate(for: complication)
				let entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: template)
				handler(entry)
			case .graphicCircular:
				let template = createTemplate(for: complication)
				let entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: template)
				handler(entry)
			case .modularSmall:
				let template = createTemplate(for: complication)
				let entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: template)
				handler(entry)
			case .modularLarge:
				let template = createTemplate(for: complication)
				let entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: template)
				handler(entry)
			case .utilitarianSmall:
				let template = createTemplate(for: complication)
				let entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: template)
				handler(entry)
			case .utilitarianSmallFlat:
				let template = createTemplate(for: complication)
				let entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: template)
				handler(entry)
			case .utilitarianLarge:
				let template = createTemplate(for: complication)
				let entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: template)
				handler(entry)
			default:
				handler(nil)
		}
//        handler(nil)
	}

	func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
		// Call the handler with the timeline entries after the given date
		handler(nil)
	}

	// MARK: - Sample Templates
	private func createTemplate(for complication: CLKComplication) -> CLKComplicationTemplate {
		switch complication.family {
			case .circularSmall:
				let image = UIImage(named: "Complication/Circular")!
				let imageProvider = CLKImageProvider(onePieceImage: image)
				let circularSmall = CLKComplicationTemplateCircularSmallSimpleImage(imageProvider: imageProvider )
				#warning("Implementation is not complete yet.")
				// you must implement all supported complications for the templates.
				return circularSmall
			case .graphicCircular:
				return CLKComplicationTemplateGraphicCircularView(GraphicCircular())
			default:
				let image = UIImage(named: "Complication/Circular")!
				let imageProvider = CLKImageProvider(onePieceImage: image)
				let circularSmall = CLKComplicationTemplateCircularSmallSimpleImage(imageProvider: imageProvider )
				return circularSmall
		}
	}

	func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
		// This method will be called once per supported complication, and the results will be cached
		let sampleText = "Deice 737?"
		switch complication.family {
			case .circularSmall:
				let image = UIImage(named: "Complication/Circular")!
				let imageProvider = CLKImageProvider(onePieceImage: image)
				let circularSmall = CLKComplicationTemplateCircularSmallSimpleImage(imageProvider: imageProvider )
				handler(circularSmall)
			case .graphicBezel:
				guard let image = UIImage(named: "Complication/Graphic Bezel") else { return }
				let fullColorImage = CLKFullColorImageProvider(fullColorImage: image)
				let graphicCircularImageTemplate = CLKComplicationTemplateGraphicCircularImage(imageProvider: fullColorImage)
				let text = CLKSimpleTextProvider(text: sampleText)
				let graphicBezelTemplate = CLKComplicationTemplateGraphicBezelCircularText(circularTemplate: graphicCircularImageTemplate, textProvider: text)
				handler(graphicBezelTemplate)
			case .graphicCorner:
				guard let image = UIImage(named: "Complication/Graphic Corner") else { return }
				let fullColorImageProvider = CLKFullColorImageProvider(fullColorImage: image)
				let text = CLKSimpleTextProvider(text: sampleText)
				let graphicCorner = CLKComplicationTemplateGraphicCornerTextImage(textProvider: text, imageProvider: fullColorImageProvider)
				handler(graphicCorner)
			case .modularSmall:
				guard let image = UIImage(named: "Complication/Modular") else { return }
				let modularSmall = CLKComplicationTemplateModularSmallSimpleImage(imageProvider: CLKImageProvider(onePieceImage: image))
				handler(modularSmall)
			case .modularLarge:
				let header = CLKSimpleTextProvider(text: sampleText)
				let body1 = CLKSimpleTextProvider(text: "Safety Is No Accident!")
				let modularLarge = CLKComplicationTemplateModularLargeStandardBody(headerTextProvider: header, body1TextProvider: body1)
				handler(modularLarge)
			case .utilitarianSmall:
				guard let image = UIImage(named: "Complication/Utilitarian") else { return }
				let imageProvider = CLKImageProvider(onePieceImage: image)
				let utilitarianSmall = CLKComplicationTemplateUtilitarianSmallSquare(imageProvider: imageProvider)
				handler(utilitarianSmall)
			case .utilitarianSmallFlat:
				let text = CLKSimpleTextProvider(text: sampleText, shortText: "737")
				let utilitarianSmallFalt = CLKComplicationTemplateUtilitarianSmallFlat(textProvider: text)
				handler(utilitarianSmallFalt)
			case .utilitarianLarge:
				let text = CLKSimpleTextProvider(text: sampleText, shortText: "737")
				let utilitarianLarge = CLKComplicationTemplateUtilitarianLargeFlat(textProvider: text)
				handler(utilitarianLarge)
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

