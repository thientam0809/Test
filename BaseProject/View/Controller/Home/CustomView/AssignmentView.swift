//
//  AssignmentView.swift
//  BaseProject
//
//  Created by Nguyen Khanh Thien Tam on 16/06/2024.
//

import UIKit

protocol AssignmentViewDelegate: AnyObject {
    func view(_ view: AssignmentView, needPerfom action: AssignmentView.Action)
}

class AssignmentView: BaseView {
    
    enum Action {
        case update(id: String)
    }

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var statusStackView: UIStackView!
    @IBOutlet private weak var missedLabel: UILabel!
    @IBOutlet private weak var numberExLabel: UILabel!
    @IBOutlet private weak var completedLabel: UILabel!
    @IBOutlet private weak var tickImageView: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    
    var viewModel: AssignmentViewModel? {
        didSet {
            updateView()
        }
    }
    weak var delegate: AssignmentViewDelegate?
    
    override func setup() {
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTouchUpInside)))
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        if viewModel.isSelect() {
            tickImageView.isHidden = false
            tickImageView.image = UIImage(named: "filled")
            containerView.backgroundColor = .hexStringToUIColor(hex: "#7470EF")
        } else {
            tickImageView.isHidden = true
        }
        titleLabel.text = viewModel.item.title
        missedLabel.isHidden = !viewModel.isMissed()
        missedLabel.text = viewModel.getMissed()
        completedLabel.isHidden = !viewModel.isCompleted()
        completedLabel.text = viewModel.getCompleted()
        numberExLabel.isHidden = viewModel.isCompleted()
        numberExLabel.text = viewModel.getNumberWorkout()
    }
    
    // MARK: - @Objc private func
    @objc private func tapTouchUpInside() {
        delegate?.view(self, needPerfom: .update(id: viewModel?.item.id ?? ""))
    }
}
