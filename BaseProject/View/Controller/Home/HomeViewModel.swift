import Foundation

enum StatusWorkout: Int {
    case misssed = 0
    case completed = 2
    
}

final class HomeViewModel {
    
    // MARK: - Properties
    private let useCase: HomeUseCase
    var items: [DayDatum] = []
    let daysOfWeek = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
    private(set) var idSelect: String?
    
    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
    
    // MARK: - Methods
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfRowInSection(in section: Int) -> Int {
        return items.count
    }
    
    func setIdSelect(id: String) {
        idSelect = id
    }
    
    func viewModelForItem(at indexPath: IndexPath) -> HomeCellViewModel {
        let nowDay: String = Date().dayOfWeek()
        let isToday = items[indexPath.row].day.dayOfWeek() == nowDay
        return HomeCellViewModel(item: items[indexPath.row], isToday: isToday, idSelect: idSelect ?? "")
    }
    
    func loadLocalDate() {
        items = daysOfWeek.map { day in
            DayDatum(id: "", assignments: [], trainer: "", client: "", day: day, date: "")
        }
    }
    
    func getWorkouts(completion: @escaping (Result<Workout?, Error>) -> Void) {
        useCase.getWorkouts { [weak self] result in
            guard let this = self else { return }
            
            switch result {
            case .success(let data):
                guard let lists = data?.dayData else {
                    completion(.failure(APIError.emptyOrInvalidResponse))
                    return
                }
                
                var sortedDayData: [DayDatum] = []
                var lastDate: String? = lists.first?.date
                
                for dayOfWeek in this.daysOfWeek {
                    if let filteredDay = lists.first(where: { $0.day.dayOfWeek() == dayOfWeek }) {
                        sortedDayData.append(filteredDay)
                        lastDate = filteredDay.date
                    } else {
                        if let lastDateUnwrapped = lastDate, let newDate = lastDateUnwrapped.addOneDay() {
                            let emptyDayDatum = DayDatum(id: "", assignments: [], trainer: "", client: "", day: dayOfWeek, date: newDate)
                            sortedDayData.append(emptyDayDatum)
                            lastDate = newDate
                        } else {
                            let emptyDayDatum = DayDatum(id: "", assignments: [], trainer: "", client: "", day: dayOfWeek, date: "")
                            sortedDayData.append(emptyDayDatum)
                        }
                    }
                }
                
                this.items = sortedDayData
                completion(.success(Workout(dayData: sortedDayData)))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
