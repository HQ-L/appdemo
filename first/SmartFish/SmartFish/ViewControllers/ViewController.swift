//
//  ViewController.swift
//  SmartFish
//
//  Created by hq on 2022/12/29.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let deviceCardView = CardView()
    let popupView = PopupView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "~~~BuluBulu~~~"
        setupDeviceCardView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        popupView.dismiss()
    }


}

private extension ViewController {
    func setupDeviceCardView() {
        deviceCardView.title = "测试用名"
        deviceCardView.subtitle = "测试用的描述文字"
        deviceCardView.delegate = self
        view.addSubview(deviceCardView)
        deviceCardView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(44)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(160)
        }
        deviceCardView.show()
    }
}

extension ViewController: CardViewDelegate {
    func longPressView() {
        popupView.originTitle = deviceCardView.titleLabel.text
        popupView.originSubtitle = deviceCardView.subtiltleLabel.text
        popupView.delegate = self
        view.addSubview(popupView)
        popupView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        popupView.show()
    }

    func clickView() {
        let vc = DeviceViewController()
        navigationController?.pushViewController(vc, animated: true)
    }


}

extension ViewController: PopupViewDelegate {
    func clickSureButton(title: String?, subtitle: String?) {
        deviceCardView.titleLabel.text = title
        deviceCardView.subtiltleLabel.text = subtitle
    }


}
