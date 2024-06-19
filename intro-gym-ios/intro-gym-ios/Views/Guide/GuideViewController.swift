//
//  GuideViewController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 08.05.2024.
//

import UIKit

class GuideViewController: UIViewController {
    
    private var guideTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        createTable()
        setupLayout()
    }
    
    private func configureView() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        view.backgroundColor = .background
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .background
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    private func createTable() {
        guideTableView = UITableView(frame: .zero)
        guideTableView.translatesAutoresizingMaskIntoConstraints = false
        guideTableView.register(UITableViewCell.self, forCellReuseIdentifier: "GuideCell")
        guideTableView.dataSource = self
        guideTableView.delegate = self
        guideTableView.rowHeight = 150
        guideTableView.backgroundColor = .clear
        guideTableView.separatorStyle = .none
    }
    
    private func setupLayout() {
        view.addSubview(guideTableView)
        
        NSLayoutConstraint.activate([
            guideTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            guideTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            guideTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            guideTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension GuideViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GuideCell", for: indexPath)
        
        let guideBackground = UIImageView()
        guideBackground.translatesAutoresizingMaskIntoConstraints = false
        guideBackground.image = UIImage(named: "arcticleBackground")
        guideBackground.contentMode = .scaleAspectFill
        guideBackground.clipsToBounds = true
        cell.contentView.addSubview(guideBackground)
        
        let guideTitle = UILabel()
        guideTitle.translatesAutoresizingMaskIntoConstraints = false
        guideTitle.text = "Упражнения"
        guideTitle.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        guideTitle.textColor = .white
        cell.contentView.addSubview(guideTitle)
        
        let guideArcticleCount = UILabel()
        guideArcticleCount.translatesAutoresizingMaskIntoConstraints = false
        guideArcticleCount.text = "Количество: 30"
        guideArcticleCount.font = UIFont.systemFont(ofSize: 14, weight: .light)
        guideArcticleCount.textColor = .accent
        cell.contentView.addSubview(guideArcticleCount)
        
        NSLayoutConstraint.activate([
            guideBackground.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor),
            guideBackground.heightAnchor.constraint(equalTo: cell.contentView.heightAnchor),
            
            guideTitle.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 100),
            guideTitle.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 15),
            
            guideArcticleCount.topAnchor.constraint(equalTo: guideTitle.bottomAnchor),
            guideArcticleCount.leadingAnchor.constraint(equalTo: guideTitle.leadingAnchor),
        ])
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.clipsToBounds = true
        
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listExercisesVC = MuscleGroupListViewController()
        navigationController?.pushViewController(listExercisesVC, animated: true)
    }
    
    
}
