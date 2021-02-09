//
//  ButtonView.swift
//  Deice737
//
//  Created by Daniel O'Leary on 2/5/21.
//

import SwiftUI

struct EvaluateButtonView: View {
	let title: String
	let backgroundColor: Color

    var body: some View {
		Text(title)
			.frame(maxWidth: 200, minHeight: 40)
			.foregroundColor(.white)
//			.font(.title)
			.background(RoundedRectangle(cornerRadius: 20).fill(backgroundColor))
			.shadow(color: Color.black.opacity(0.6), radius: 7, x: 5, y: 5)
			.padding()
    }
}

struct YesNoButtonView: View {
	let title: String
	let condition: Bool

	var body: some View {
		Text(title)
			.frame(width: 100, height: 50)
			.background(RoundedRectangle(cornerRadius: 30).fill(condition ? Color.green : Color.red))
			.foregroundColor(.white)
	}
}


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
		EvaluateButtonView(title: "Evaluate", backgroundColor: .blue)
    }
}
