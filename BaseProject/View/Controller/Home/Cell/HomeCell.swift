import UIKit

protocol HomeCellDelegate: AnyObject {
    func cell(_ cell: HomeCell, needPerfom action: HomeCell.Action)
}

final class HomeCell: UITableViewCell {
    
    enum Action {
        case isTap(id: String)
    }
    
    // MARK: - IBOulets
    @IBOutlet private weak var dateOfWeekLabel: UILabel!
    @IBOutlet private weak var dateOfMonthLabel: UILabel!
    @IBOutlet private weak var assignmentsStackView: UIStackView!
    
    // MARK: - Properties
    var viewModel: HomeCellViewModel? {
        didSet {
            updateView()
        }
    }
    weak var delegate: HomeCellDelegate?
    
    // MARK: - Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Private func
    private func updateView() {
        guard let item = viewModel?.item, let isToday = viewModel?.isToday else { return }
        dateOfWeekLabel.textColor = isToday ? .hexStringToUIColor(hex: "#7470EF") : .hexStringToUIColor(hex: "#7B7E91")
        dateOfMonthLabel.textColor = isToday ? .hexStringToUIColor(hex: "#7470EF") : .hexStringToUIColor(hex: "#1E0A3C")
        if item.assignments.isEmpty {
            dateOfWeekLabel.text = item.day
            dateOfMonthLabel.text = item.date.extractDay()
        } else {
            dateOfWeekLabel.text = item.day.dayOfWeek()
            dateOfMonthLabel.text = item.day.extractDay()
        }
        
        assignmentsStackView.subviews.forEach { $0.removeFromSuperview() }
        if item.assignments.isEmpty {
            let emptyView = EmptyView()
            assignmentsStackView.addArrangedSubview(emptyView)
            layout(from: emptyView, to: assignmentsStackView)
        } else {
            for item in item.assignments {
                let assignmentView = AssignmentView()
                assignmentView.delegate = self
                assignmentView.viewModel = AssignmentViewModel(item: item,
                                                               idSelect: viewModel?.idSelect ?? "")
                assignmentsStackView.addArrangedSubview(assignmentView)
                layout(from: assignmentView, to: assignmentsStackView)
            }
        }
    }
    
    private func layout(from child: UIView, to parent: UIView) {
        child.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = child.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0)
        let trailingConstraint = child.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: 0)
        let height = child.heightAnchor.constraint(equalToConstant: 72)
        
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, height])
    }
}

extension HomeCell: AssignmentViewDelegate {
    
    func view(_ view: AssignmentView, needPerfom action: AssignmentView.Action) {
        switch action {
        case .update(let id):
            delegate?.cell(self, needPerfom: .isTap(id: id))
        }
    }
}
