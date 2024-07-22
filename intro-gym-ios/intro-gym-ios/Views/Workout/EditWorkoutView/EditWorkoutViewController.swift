import UIKit

class EditWorkoutViewController: UIViewController {
    
    var exercises: [ExerciseEntity] = []
    var exerciseSelect: ExerciseEntity?
    var exerciseInfo: ExerciseInfoEntity?
    var workout: WorkoutEntity?
    
    private var excersicesTableView: UITableView!
    
    private let workoutNameField = Factory.createHeaderWithField(header: "Название тренировки", fieldPlaceholder: "Введите название...", fieldTag: 1)
    private let workoutDescriptionField = Factory.createHeaderWithField(header: "Описание тренировки", fieldPlaceholder: "Введите описание...", fieldTag: 2)
    private let tableViewHeader = Factory.createHeader(text: "Ваши упражнения")
    private let addExcersiceButton = Factory.createButton(title: "Добавить упражнение", type: .stroke)
    private let saveWorkoutButton = Factory.createButton(title: "Сохранить", type: .fill)
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 40
        return stack
    }()
    
    private lazy var stackButtons: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()

    private var isWorkoutSaved = false
    private var isNavigatingToChildController = false
    private var isNewWorkout = false

    override func viewDidLoad() {
        super.viewDidLoad()

        viewConfigure()
        createTable()
        setupLayout()
        getExerciseInfo()
        hideKeyboardWhenTappedAround()
        
        if workout == nil {
            createNewWorkout()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllExercises()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isNewWorkout && !isWorkoutSaved && !isNavigatingToChildController, let workout = workout {
            print("Удалена тренировка с ID: \(workout.id)")
            CoreDataManager.shared.deleteWorkout(workout: workout)
        }
    }

    private func createNewWorkout() {
        CoreDataManager.shared.createWorkout(name: "", descr: "", exercises: [])
        let lastWorkoutId = CoreDataManager.shared.getLastCreatedWorkout()
        workout = CoreDataManager.shared.getWorkoutById(id: Int64(lastWorkoutId))
        isNewWorkout = true
        if workout != nil {
            print("Создана новая тренировка с ID: \(lastWorkoutId)")
        } else {
            print("Не удалось создать новую тренировку")
        }
    }
    
    private func getExerciseInfo() {
        
    }
    
    private func getAllExercises() {
        guard let workout = workout else { return }
        if let fetchedExercises = CoreDataManager.shared.getAllExersicesByWorkoutId(workoutId: workout.id) {
            exercises = fetchedExercises
            excersicesTableView.reloadData()
        }
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    private func viewConfigure() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        if workout == nil {
            navigationItem.title = "Создание тренировки"
        } else {
            navigationItem.title = workout?.name
        }
        navigationController?.navigationBar.tintColor = .main
        view.backgroundColor = .background
    }
    
    private func createTable() {
        excersicesTableView = UITableView(frame: .zero)
        excersicesTableView.translatesAutoresizingMaskIntoConstraints = false
        excersicesTableView.register(CustomExerciseCell.self, forCellReuseIdentifier: "ExcersiceCell")
        excersicesTableView.delegate = self
        excersicesTableView.dataSource = self
        excersicesTableView.separatorStyle = .none
        excersicesTableView.backgroundColor = .clear
        excersicesTableView.rowHeight = 78
    }
    
    private func setupLayout() {
        if workout != nil {
            let name = workoutNameField.viewWithTag(1) as? UITextField
            name?.text = workout?.name
            let descr = workoutDescriptionField.viewWithTag(2) as? UITextField
            descr?.text = workout?.descr
        }
        
        stack.addArrangedSubview(workoutNameField)
        stack.addArrangedSubview(workoutDescriptionField)
        
        stackButtons.addArrangedSubview(addExcersiceButton)
        stackButtons.addArrangedSubview(saveWorkoutButton)
        
        addExcersiceButton.addTarget(self, action: #selector(didTapAddExercise), for: .touchUpInside)
        saveWorkoutButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        
        view.addSubview(stack)
        view.addSubview(stackButtons)
        view.addSubview(tableViewHeader)
        view.addSubview(excersicesTableView)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableViewHeader.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 40),
            tableViewHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            excersicesTableView.topAnchor.constraint(equalTo: tableViewHeader.bottomAnchor, constant: 20),
            excersicesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            excersicesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            excersicesTableView.bottomAnchor.constraint(equalTo: addExcersiceButton.topAnchor, constant: -20),
            
            stackButtons.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            saveWorkoutButton.leadingAnchor.constraint(equalTo: stackButtons.leadingAnchor),
            saveWorkoutButton.trailingAnchor.constraint(equalTo: stackButtons.trailingAnchor),
            
            addExcersiceButton.leadingAnchor.constraint(equalTo: stackButtons.leadingAnchor),
            addExcersiceButton.trailingAnchor.constraint(equalTo: stackButtons.trailingAnchor),
        ])
        
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func didTapSave() {
        guard let nameTextField = workoutNameField.viewWithTag(1) as? UITextField,
              let name = nameTextField.text, !name.isEmpty,
              let descrTextField = workoutDescriptionField.viewWithTag(2) as? UITextField,
              let descr = descrTextField.text else {
            print("Не удалось сохранить тренировку")
            return
        }
        
        guard let workout = workout else {
            CoreDataManager.shared.createWorkout(name: name, descr: descr, exercises: exercises)
            navigationController?.popViewController(animated: true)
            print("Тренировка создана")
            isWorkoutSaved = true
            return
        }
        
        CoreDataManager.shared.updateWorkoutById(id: workout.id, newName: name, newDescr: descr, newExercises: exercises)
        print("Тренировка обновлена")
        
        navigationController?.popViewController(animated: true)
        isWorkoutSaved = true
    }
    
    @objc private func didTapAddExercise() {
        isNavigatingToChildController = true
        let muscleGroupListVC = MuscleGroupListViewController()
        muscleGroupListVC.hidesBottomBarWhenPushed = true
        muscleGroupListVC.shouldShowAddButton = true
        muscleGroupListVC.delegate = self
        navigationController?.pushViewController(muscleGroupListVC, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isNavigatingToChildController = false
    }
}

extension EditWorkoutViewController: ExerciseDescriptionViewControllerDelegate {
    func getWorkoutId() -> Int64 {
        print("EditWorkout delegate method. Workout id: ", workout?.id ?? 0)
        return workout?.id ?? 0
    }
}

extension EditWorkoutViewController: EditExerciseViewControllerDelegate {
    func getExercise() -> ExerciseEntity? {
        guard let exerciseSelect = exerciseSelect else { return nil }
        return exerciseSelect
    }
    
    func didUpdateExercise(_ exercise: ExerciseEntity) {
        if let index = exercises.firstIndex(where: { $0.id == exercise.id }) {
            exercises[index] = exercise
            excersicesTableView.reloadData()
        }
    }
}

extension EditWorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExcersiceCell", for: indexPath) as! CustomExerciseCell
        
        let exercise = exercises[indexPath.section]

        var exerciseImage = ""
        if let fetchedExerciseInfo = CoreDataManager.shared.getExerciseInfoById(id: exercises[indexPath.section].exerciseInfoId) {
            exerciseImage = fetchedExerciseInfo.img ?? ""
        }
        
        cell.configure(with: exercise.name,
                       approaches: Int(exercise.sets),
                       repetitions: Int(exercise.reps),
                       weight: Int(exercise.weight),
                       image: UIImage(named: exerciseImage))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isNavigatingToChildController = true
        let editExerciseVC = EditExerciseViewController()
        editExerciseVC.modalPresentationStyle = .pageSheet
        editExerciseVC.delegate = self
        exerciseSelect = exercises[indexPath.section]
        present(editExerciseVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { action, view, complectionHandler in
            let exerciseToDelete = self.exercises[indexPath.section]
            CoreDataManager.shared.deleteExercise(exercise: exerciseToDelete)
            self.getAllExercises()
            complectionHandler(true)
        }
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
