enum MainViewErrorType: String {
   case inconsistency = "This should not happen, review your code"
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
   var windInformation: WindInformationViewModel?
}
