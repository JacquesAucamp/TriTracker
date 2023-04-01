//
//  ContentView.swift
//  TriTracker
//
//  Created by Jacques Aucamp on 2023/04/01.
//

import SwiftUI

struct QuestionnaireView: View {
	// State properties to keep track of the current question index and user's answers.
	@State private var currentQuestionIndex = 0
	@State private var answers: [String] = ["", "", ""]

	// An array of the questions to be asked in the questionnaire.
	private let questions = ["What is your current fitness level?", "What is your primary sport?", "What is your goal for this season?"]

	// An array of the options for each question. The options are nested within the questions array.
	private let options = [
		["Beginner", "Intermediate", "Advanced"],
		["Running", "Cycling", "Swimming"],
		["Complete a race", "Improve my performance", "Maintain my fitness"]
	]
	
	// Each question is displayed to the user one at a time, with the corresponding options displayed as buttons. The user's answer
	// is stored in the answers array at the index corresponding to the current question index.
	
	var body: some View {
		ZStack {
			// Add a gradient background that ignores the safe area
			LinearGradient(gradient: Gradient(colors: [Color("olive"), Color("light olive")]), startPoint: .center, endPoint: .bottomLeading)
				.edgesIgnoringSafeArea(.all)
			
			VStack {
				// Display the question text for the current index
				Text(questions[currentQuestionIndex])
					.font(.custom("HelveticaNeue-Medium", size: 28))
					.foregroundColor(Color(hue: 0.157, saturation: 0.98, brightness: 1.0))
					.multilineTextAlignment(.center)
					.padding()
				
				// Create a button for each option in the current question
				ForEach(0...options[currentQuestionIndex].count-1, id: \.self) { i in
					Button(action: {
						// Update the answer for the current question
						answers[currentQuestionIndex] = options[currentQuestionIndex][i]
					}) {
						// Display the option text
						Text(options[currentQuestionIndex][i])
							.font(.custom("HelveticaNeue-Bold", size: 20))
							.foregroundColor(.white)
							.padding(.vertical, 12)
							.padding(.horizontal, 20)
							// Apply different styling depending on whether the option is selected
							.background(
								answers[currentQuestionIndex] == options[currentQuestionIndex][i] ?
								RoundedRectangle(cornerRadius: 20)
									.fill(Color.green)
								: RoundedRectangle(cornerRadius: 20)
									.fill(Color.white.opacity(0.1))
							)
							.overlay(
									RoundedRectangle(cornerRadius: 20)
											.stroke(Color.white, lineWidth: 2)
							)
							.clipShape(RoundedRectangle(cornerRadius: 20))
					}
					.padding(.vertical, 6)
				}
				
				// Define the navigation buttons to move between questions
				HStack {
					// Define the "Previous" button and its functionality
					Button(action: {
						if currentQuestionIndex > 0 {
							withAnimation{
								currentQuestionIndex -= 1
							}
						}
					}) {
						Text("Previous")
							.font(.custom("HelveticaNeue-Bold", size: 20))
							.foregroundColor(Color(hue: 0.157, saturation: 0.98, brightness: 1.0))
							.padding()
							.background(
								RoundedRectangle(cornerRadius: 20)
									.stroke(Color(hue: 0.157, saturation: 0.98, brightness: 1.0), lineWidth: 2)
							)
					}
					.padding()
					
					Spacer()
					
					// Define the "Next" or "Submit" button and its functionality
					Button(action: {
						if currentQuestionIndex < 2 {
							withAnimation{
								currentQuestionIndex += 1
							}
						} else {
							// TODO: Submit the questionnaire and save the answers
						}
					}) {
						Text(currentQuestionIndex == 2 ? "Submit" : "Next")
							.font(.custom("HelveticaNeue-Bold", size: 20))
							.foregroundColor(Color(hue: 0.157, saturation: 0.98, brightness: 1.0))
							.padding()
							.background(
								RoundedRectangle(cornerRadius: 20)
									.stroke(Color(hue: 0.157, saturation: 0.98, brightness: 1.0), lineWidth: 2)
							)
					}
					.padding(.trailing)
					.disabled(answers[currentQuestionIndex].isEmpty)
				}
				.padding()
			}
			.transition(.move(edge: .leading))
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      QuestionnaireView()
    }
}



