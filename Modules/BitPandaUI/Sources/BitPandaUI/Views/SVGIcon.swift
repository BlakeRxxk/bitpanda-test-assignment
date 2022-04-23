//
//  SVGIcon.swift
//  BitPandaUI
//
//  Created by Oleg Kurgaev on 20.04.2022.
//

import Foundation
import PINCache
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
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in

            self?.dataFetcher.requestData(at: model.light!) { res in
                switch res {
                case .success(let data):
                    self?.lightLogo = SVGKImage(data: data)
                default: break //
                }

            }

            self?.dataFetcher.requestData(at: model.dark!) { res in
                switch res {
                case .success(let data):
                    self?.darkLogo = SVGKImage(data: data)
                default: break //
                }

            }
            DispatchQueue.main.async { [weak self] in
                self?.updateLogo()
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

    private var lightLogo: SVGKImage?
    private var darkLogo: SVGKImage?
    private var activeConstraints: [NSLayoutConstraint] = []

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
        imageView.image = traitCollection.userInterfaceStyle == .dark ? darkLogo : lightLogo
    }
}

extension SVGIcon {
    public struct Model {
        public let light: URL?
        public let dark: URL?

        public init(light: URL?, dark: URL?) {
            self.light = light
            self.dark = dark
        }
    }
}

// MARK: - SVGDataFetcher

class SVGDataFetcher {

    enum FetcherError: Error {
        case requestFailed
        case dataCorrupted
    }

    func requestData(at url: URL, completion: @escaping (Result<Data, FetcherError>) -> Void) {
        PINCache.shared.object(forKeyAsync: url.absoluteString) { _, _, object in
            guard let object = object as? Data else { return }
            completion(.success(object))
        }
        let task = URLSession.shared.dataTask(with: url) { responseData, _, responseError in
            DispatchQueue.main.async {

                if responseError != nil {
                    completion(.failure(SVGDataFetcher.FetcherError.requestFailed))
                } else if let data = responseData {

                    PINCache.shared.setObject(data, forKey: url.absoluteString)
                    completion(.success(data))
                } else {
                    completion(.failure(SVGDataFetcher.FetcherError.dataCorrupted))
                }
            }
        }

        task.resume()
    }
}
