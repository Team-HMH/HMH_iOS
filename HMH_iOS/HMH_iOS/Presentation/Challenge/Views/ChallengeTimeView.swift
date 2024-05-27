//
//  ChallengeTimeView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/27/24.
//

import SwiftUI


struct ChallengeTimeView: View {
    
    @StateObject
    var screenViewModel = ScreenTimeViewModel()
    @StateObject
    var viewModel: OnboardingViewModel
    
    init() {
        let viewModel = ScreenTimeViewModel()
        _screenViewModel = StateObject(wrappedValue: viewModel)
        _viewModel = StateObject(wrappedValue: OnboardingViewModel(viewModel: viewModel))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer(minLength: 0)
                .frame(height: 60)
            OnboardingProgressView()
            Spacer(minLength: 0)
                .frame(height: 31)
            OnboardingTitleView()
            SurveyContainerView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            NextButtonView(viewModel: viewModel)
        }
        .padding(20)
        .background(.blackground, ignoresSafeAreaEdges: .all)
    }
}


struct ChallengeGoalTimeView: View {
    var timesHour = Array(0...1).map { String($0) }
    var timesMinute = Array(0...59).map { String($0) }
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                PickerView(times: timesHour, selectedTimes: $viewModel.selectedAppHour, viewModel: viewModel)
                    .frame(width: 67)
                Text("시간")
                    .font(.text2_medium_20)
                    .foregroundColor(.gray2)
                PickerView(times: timesMinute, selectedTimes: $viewModel.selectedAppMinute, viewModel: viewModel)
                    .frame(width: 67)
                Text("분")
                    .font(.text2_medium_20)
                    .foregroundColor(.gray2)
            }
            .padding(.bottom, 200)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
    }
}



struct ChallengePickerView: UIViewRepresentable {
    var times: [String]
    @Binding var selectedTimes: String
    @ObservedObject var viewModel: ChallengeViewModel
    
    func makeUIView(context: Context) -> UIPickerView {
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        pickerView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        pickerView.dataSource = context.coordinator
        pickerView.delegate = context.coordinator
        
        return pickerView
    }
    
    func updateUIView(_ pickerView: UIPickerView, context: Context) {
        if let selectedIndex = times.firstIndex(of: selectedTimes) {
            pickerView.selectRow(selectedIndex, inComponent: 0, animated: true)
        }
    }
    
    func makeCoordinator() -> PickerCoordinator {
        return PickerCoordinator(times: times, selectedTime: $selectedTimes, viewModel: viewModel)
    }
}

class PickerCoordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    @ObservedObject var viewModel: ChallengeViewModel
    var times: [String]
    var selectedTime: Binding<String>
    
    init(times: [String], selectedTime: Binding<String>, viewModel: OnboardingViewModel) {
        self.times = times
        self.selectedTime = selectedTime
        self.viewModel = viewModel
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return times.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return times[row]
    }
     
     func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
         let time = UIColor(.whiteText)
         let font = UIFont(name: "Pretendard-Medium", size: 22)

         
         let attributes: [NSAttributedString.Key: Any] = [
             NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): time,
             NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): font
         ]
         
         return NSAttributedString(string: times[row], attributes: attributes)
     }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTime.wrappedValue = times[row]
        viewModel.isCompleted = true
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 53
    }
}

