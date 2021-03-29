//
//  UIImageView+downloaded.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 26/03/2021.
//

import UIKit

extension UIImageView {

    func downloaded(from url: URL?, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = url else { return }
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }

            DispatchQueue.main.async() {
                [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
