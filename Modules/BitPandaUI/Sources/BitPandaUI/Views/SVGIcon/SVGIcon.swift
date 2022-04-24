//
//  SVGIcon.swift
//  BitPandaUI
//
//  Created by Oleg Kurgaev on 20.04.2022.
//

import Foundation

import SVGKit
import SVGKitSwift

// MARK: - SVGIcon

public final class SVGIcon: View {

    // MARK: Lifecycle

    public override init() {
        super.init()

        createUI()
        configureUI()
        layout()
    }

    // MARK: Public

    public private(set) var imageView: SVGKFastImageView = .init(frame: .zero)

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateLogo()
    }

    public func update(with model: SVGIcon.Model) {
        guard
            let darkLogoURL = model.dark,
            let lightLogoURL = model.light else { return }

        let queue = DispatchQueue(
            label: "com.bitpanda-test.svg.datafetcher",
            qos: .utility,
            attributes: .concurrent)

        queue.async { [weak self] in
            self?.dataFetcher.requestData(at: lightLogoURL) { res in
                switch res {
                case .success(let data):
                    self?.lightLogo = SVGKImage(data: data)
                default: break
                }

            }
        }

        queue.async { [weak self] in
            self?.dataFetcher.requestData(at: darkLogoURL) { res in
                switch res {
                case .success(let data):
                    self?.darkLogo = SVGKImage(data: data)
                default: break
                }

            }
        }
    }

    public func prepareForReuse() {
        imageView.image = nil
        lightLogo = nil
        darkLogo = nil
    }

    // MARK: Private

    private var dataFetcher = SVGDataFetcher()

    private var activeConstraints: [NSLayoutConstraint] = []

    private var lightLogo: SVGKImage? {
        didSet {
            updateLogo()
        }
    }

    private var darkLogo: SVGKImage? {
        didSet {
            updateLogo()
        }
    }

    private func createUI() {
        addSubview(imageView)
    }

    private func configureUI() {
        imageView.backgroundColor = Theme.Background.icon
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
    }

    private func layout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false

        activeConstraints = [
            imageView.width.constraint(equalToConstant: Spacing.x40),
            imageView.height.constraint(equalToConstant: Spacing.x40),
        ]

        NSLayoutConstraint.activate(activeConstraints)
    }

    private func updateLogo() {
        DispatchQueue.main.async { [weak self] in
            self?.imageView.image = self?.traitCollection.userInterfaceStyle == .dark ? self?.darkLogo : self?.lightLogo
        }

    }
}
