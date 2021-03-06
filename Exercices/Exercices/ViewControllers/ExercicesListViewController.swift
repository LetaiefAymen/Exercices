//
//  ViewController.swift
//  Exercices
//
//  Created by Aymen Letaief on 09.12.21.
//

import UIKit
import ExercisesCore

class ExercicesListViewController: UIViewController {

    var datasource: [Exercise] = []
    let urlString = "https://jsonblob.com/api/jsonBlob/027787de-c76e-11eb-ae0a-39a1b8479ec2"
    
    @IBOutlet weak var tableView: UITableView!
    var exercisesViewModel: ExercisesViewModel?
    var imageLoader: ImageLoader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        exercisesViewModel!.loadAllExercices()
    }
    
    func configureViewModel() {
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration)
        
        let httpClient = URLSessionHTTPClient(session: session)
        
        let loader = RemoteExercisesLoader(url:URL(string: urlString)!,httpClient:httpClient)
        
        self.imageLoader = RemoteImageLoader(httpClient: httpClient)
        self.exercisesViewModel = ExercisesViewModel(remoteLoader: loader,favoriteStoreHelper: FavoriteStoreHelper())
        self.exercisesViewModel?.delegate = self
    }
    
    @IBAction func startExercisesClicked(_ sender: Any) {
        let viewModel = TraingingsViewModel(exercices: datasource,favoriteStoreHelper: exercisesViewModel!.favoriteStoreHelper)
        
        let bundle = Bundle(for: ExercicesListViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let vc = storyboard.instantiateViewController(withIdentifier: "TrainingViewController") as! TrainingViewController
        vc.modalPresentationStyle = .fullScreen
        viewModel.delegate = vc
        vc.trainingsViewModel = viewModel
        vc.imageLoader = imageLoader
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override public var shouldAutorotate: Bool {
       return false
     }
}


extension ExercicesListViewController: UITableViewDataSource,UITableViewDelegate  {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciceCell", for: indexPath) as! ExerciseCell
        let exercise = datasource[indexPath.row]
        
        cell.setup(exercise: exercise, isFavorite: exercisesViewModel!.isFavorite(exercise: exercise))
        cell.delegate = self
        if let urlString = exercise.cover_image_url, let imageUrl = URL(string: urlString) {
            imageLoader?.loadImage(url: imageUrl, completion: { result in
                
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        cell.exerciseImageView?.image = image
                    }
                default:
                    break
                }
                
            })
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
}


extension ExercicesListViewController: ExercisesListDelegate {
    
    func showExercises(exercises: [Exercise]) {
        self.datasource = exercises
        self.tableView.reloadData()
    }
}

extension ExercicesListViewController: ExerciseCellDelegate {
    
    func favoriteClicked(exercise: Exercise, isFavorite: Bool) {
        exercisesViewModel?.switchFavorite(exercise: exercise, curentIsFavorite: isFavorite)
    }
    
    
}
