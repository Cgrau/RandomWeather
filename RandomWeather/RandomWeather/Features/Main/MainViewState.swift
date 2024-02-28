enum MainViewErrorType: String {
   case inconsistency = "This is embarassing, this should not happen"
   case requestFailed = "Request has failed"
   case decodingFailure = "Failed decoding the json response"
}

enum MainViewState: Equatable {
   case idle
   case loading
   case loaded(MainScreenViewModel)
   case error(MainViewErrorType)
}

struct MainScreenViewModel: Equatable {
   var navigationTitle: String
   var information: MainInformationViewModel
   var sunInformation: SunInformationViewModel
   var windInformation: WindInformationViewModel?
   var extraInformation: ExtraInformationViewModel
}
