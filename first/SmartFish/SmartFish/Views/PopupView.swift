//
//  PopupView.swift
//  SmartFish
//
//  Created by hq on 2022/12/29.
//

import UIKit

protocol PopupViewDelegate: NSObjectProtocol {
    func clickSureButton(title: String?, subtitle: String?)
}

class PopupView: UIView {

    var originTitle: String?
    var originSubtitle: String?

    weak var delegate: PopupViewDelegate?

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let titleTextField = UITextField()
    private let subtitleTextField = UITextField()
    private let cancelButton = UIButton()
    private let sureButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PopupView {
    func show() {
        setupView()
        self.alpha = 0
        self.frame.origin.y += 200
        UIView.animate(withDuration: 0.3, delay: 0, animations: { [weak self] in
            guard let self = self else { return }
            self.alpha = 1
            self.frame.origin.y -= 200
        })
    }

    func dismiss() {
        self.removeFromSuperview()
    }
}

private extension PopupView {
    func setupView() {
        self.backgroundColor = .black.withAlphaComponent(0.2)
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        self.layer.shadowOffset = .init(width: 0, height: -8)
        setupCancelButton()
        setupSureButton()
        setupTitle()
        setupSubTitle()
    }

    func setupCancelButton() {
        cancelButton.setImage(UIImage(named: "arrow_down_a60"), for: .normal)
        cancelButton.addTarget(self, action: #selector(clickCancelButton), for: .touchUpInside)
        addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(4)
            make.width.equalTo(60)
            make.height.equalTo(48)
        }
    }

    func setupSureButton() {
        sureButton.setTitle("确定", for: .normal)
        sureButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        sureButton.layer.cornerRadius = 8
        sureButton.titleLabel?.textColor = .white
        sureButton.backgroundColor = .systemBlue.withAlphaComponent(0.6)
        sureButton.addTarget(self, action: #selector(clickSureButton), for: .touchUpInside)
        addSubview(sureButton)
        sureButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.height.equalTo(35)
            make.width.equalTo(70)
        }
    }

    func setupTitle() {
        titleLabel.text = "名称"
        titleLabel.font = .systemFont(ofSize: 18)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalTo(cancelButton.snp.bottom).offset(24)
        }

        titleTextField.text = originTitle
        titleTextField.textAlignment = .natural
        titleTextField.font = .systemFont(ofSize: 18)
        titleTextField.textColor = .black.withAlphaComponent(0.8)
        addSubview(titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalTo(titleLabel)
            make.height.equalTo(titleLabel)
        }
    }

    func setupSubTitle() {
        subtitleLabel.text = "备注"
        subtitleLabel.font = .systemFont(ofSize: 18)
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }

        subtitleTextField.text = originSubtitle
        subtitleTextField.font = .systemFont(ofSize: 18)
        subtitleTextField.textColor = .black.withAlphaComponent(0.8)
        subtitleTextField.textAlignment = .natural
        addSubview(subtitleTextField)
        subtitleTextField.snp.makeConstraints { make in
            make.leading.equalTo(subtitleLabel.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalTo(subtitleLabel)
            make.height.equalTo(subtitleLabel)
//            make.bottom.equalToSuperview().offset(-20)
        }
    }

    func dismissWithAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0, animations: { [weak self] in
            guard let self = self else { return }
            self.frame.origin.y += 200
            self.alpha = 0
        }) { _ in
            self.dismiss()
        }
    }
}


// MARK: Gesture Actions
private extension PopupView {
    @objc func clickCancelButton() {
        self.dismissWithAnimation()
    }

    @objc func clickSureButton() {
        delegate?.clickSureButton(title: titleTextField.text, subtitle: subtitleTextField.text)
        self.dismissWithAnimation()
    }
}
