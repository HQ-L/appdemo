//
//  CardView.swift
//  SmartFish
//
//  Created by hq on 2022/12/29.
//

import UIKit

protocol CardViewDelegate: NSObjectProtocol {
    func clickView()
    func longPressView()
}

class CardView: UIView {

    weak var delegate: CardViewDelegate?

    var title: String = ""
    var subtitle: String = ""
    let titleLabel = UILabel()
    let subtiltleLabel = UILabel()

    private let titleImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// MARK: interface
extension CardView {
    func show() {
        setupView()
    }
}


private extension CardView {

    func setupView() {
        self.layer.cornerRadius = 8
        self.backgroundColor = .black.withAlphaComponent(0.2)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.addGestureRecognizer(tapGesture)
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
        self.addGestureRecognizer(longPressGesture)
        setupImageView()
        setupTitleLabel()
        setupSubtitleLabel()
    }

    func setupImageView() {
        titleImageView.backgroundColor = .blue.withAlphaComponent(0.4)
        titleImageView.layer.cornerRadius = 40
        addSubview(titleImageView)
        titleImageView.snp.makeConstraints { make in
            make.height.width.equalTo(80)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
        }
    }

    func setupTitleLabel() {
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 18)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalTo(titleImageView.snp.centerY).offset(-1)
        }
    }

    func setupSubtitleLabel() {
        subtiltleLabel.text = subtitle
        subtiltleLabel.font = .systemFont(ofSize: 12)
        subtiltleLabel.numberOfLines = 2
        addSubview(subtiltleLabel)
        subtiltleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
        }
    }

}

// MARK: GestureActions
private extension CardView {

    @objc func tapAction(_ tap: UITapGestureRecognizer) {
        delegate?.clickView()
    }

    @objc func longPressAction(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
            case .began:
                UIView.animate(withDuration: 0.3, delay: 0, animations: {
                    self.backgroundColor = .black.withAlphaComponent(0.8)
                })
            case .ended:
                self.backgroundColor = .black.withAlphaComponent(0.2)
                delegate?.longPressView()
            default:
                self.backgroundColor = .black.withAlphaComponent(0.2)
        }
    }
}
