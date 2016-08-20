//
//  ViewController.swift
//  TransformingView
//
//  Created by Shane Qi on 8/20/16.
//  Copyright © 2016 Shane Qi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet var container: UIView!
	@IBOutlet var contentView: UIView!
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var subtitleLabel: UILabel!
	
	var imageHeightExpanded: NSLayoutConstraint!
	var imageHeightCollapsed: NSLayoutConstraint!
	
	var containerWidthExpanded: NSLayoutConstraint!
	var containerWidthCollapsed: NSLayoutConstraint!
	
	var containerHeightExpanded: NSLayoutConstraint!
	var containerHeightCollapsed: NSLayoutConstraint!
	
	var expandedConstraints: [NSLayoutConstraint] {
		return [imageHeightExpanded, containerWidthExpanded, containerHeightExpanded]
	}
	
	var collapsedConstraints: [NSLayoutConstraint] {
		return [imageHeightCollapsed, containerWidthCollapsed, containerHeightCollapsed]
	}
	
	var state: State = .Collapsed {
		didSet {
			switch state {
			case .Expanded:
				collapsedConstraints.forEach({ $0.isActive = false })
				expandedConstraints.forEach({ $0.isActive = true })
				UIView.animate(withDuration: 0.5, animations: {
					self.container.layoutIfNeeded()
				})
			case .Collapsed:
				collapsedConstraints.forEach({ $0.isActive = true })
				expandedConstraints.forEach({ $0.isActive = false })
				UIView.animate(withDuration: 0.7, animations: {
					self.container.layoutIfNeeded()
				})
			}
		}
	}
	
	enum State {
		case Expanded, Collapsed
	}
	
	override func viewDidLoad() {
		
		[container, contentView, imageView, titleLabel, subtitleLabel].forEach({
			$0?.translatesAutoresizingMaskIntoConstraints = false
		})
		
		contentView.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
		contentView.heightAnchor.constraint(equalTo: container.heightAnchor).isActive = true
		contentView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
		contentView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
		
		containerWidthExpanded = container.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8)
		containerWidthCollapsed = container.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3)
		containerWidthCollapsed.isActive = true
		
		containerHeightExpanded = container.bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8)
		containerHeightCollapsed = container.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
		containerHeightCollapsed.isActive = true
		
		container.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		container.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
		
		
		imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
		imageView.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
		imageView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
		
		imageHeightExpanded = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 2/3)
		imageHeightCollapsed = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1)
		imageHeightCollapsed.isActive = true
		
		
		titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8).isActive = true
		titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
		titleLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
		titleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
		
		subtitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8).isActive = true
		subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
		subtitleLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
		subtitleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
		
		container.layer.shadowOffset = CGSize(width: 0, height: 3)
		container.layer.shadowOpacity = 0.5
		container.layer.cornerRadius = 5
		container.layer.masksToBounds = false
		
	}
	
	@IBAction func goAnimation() {
		switch state {
		case .Collapsed:
			state = .Expanded
		case .Expanded:
			state = .Collapsed
		}
		
	}
	
}

