//
//  TripsViewController.swift
//  Stayzy
//
//  Created by Sahil ChowKekar on 3/29/25.
//

import UIKit

class TripsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let titleLabel = UILabel()
        titleLabel.text = "Trips"
        titleLabel.font = .boldSystemFont(ofSize: 34)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let subtitleLabel = UILabel()
        subtitleLabel.text = "No trips booked...yet!"
        subtitleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        let descLabel = UILabel()
        descLabel.text = "Time to dust off your bags and start planning your next adventure."
        descLabel.textColor = .gray
        descLabel.font = .systemFont(ofSize: 16)
        descLabel.numberOfLines = 0
        descLabel.translatesAutoresizingMaskIntoConstraints = false

        let button = UIButton(type: .system)
        button.setTitle("Start searching", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        let helpLabel = UILabel()
        let attributed = NSMutableAttributedString(
            string: "Can’t find your reservation here? ",
            attributes: [.foregroundColor: UIColor.gray]
        )
        attributed.append(NSAttributedString(
            string: "Visit the Help Center",
            attributes: [.font: UIFont.boldSystemFont(ofSize: 14),
                         .underlineStyle: NSUnderlineStyle.single.rawValue]
        ))
        helpLabel.attributedText = attributed
        helpLabel.font = .systemFont(ofSize: 14)
        helpLabel.numberOfLines = 0
        helpLabel.translatesAutoresizingMaskIntoConstraints = false

        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, descLabel, button, helpLabel])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
