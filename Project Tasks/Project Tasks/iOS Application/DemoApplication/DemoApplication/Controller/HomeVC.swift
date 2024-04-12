
import UIKit
import NetworkManagerSDK

//MARK: -------- Class --------

class HomeVC: UIViewController {
    
    //MARK: -------- UI Elements Outlets --------
    
    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var tblVwList: UITableView?
    
    //MARK: -------- Variables --------
    
    var activityIndicator: UIActivityIndicatorView?
    var arrRecipes: [Recipe] = []
    
    
    //MARK: -------- Screen Lifecycle --------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUIElements()
        self.callAPIToGetRecipesList()
    }
    
    //MARK: -------- Custom Functions --------
    
    // Setting Up UI Elements
    private func setUpUIElements () {
        
        self.setUpActivityIndicator()
        self.setUpTableView()
        self.setUpDefaultData()
    }
    
    // Setting Up Activity Indicator
    private func setUpActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.color = .white
        activityIndicator?.center = self.view.center
        activityIndicator?.hidesWhenStopped = true
        view.addSubview(activityIndicator ?? UIActivityIndicatorView())
    }
    
    // Setting Up Table View
    private func setUpTableView() {
        
        let cell = UINib(nibName: "HomeMenuCell", bundle: nil)
        self.tblVwList?.register(cell, forCellReuseIdentifier:"HomeMenuCell")
        
        tblVwList?.delegate = self
        tblVwList?.dataSource = self
        self.tblVwList?.backgroundColor = UIColor.clear
        self.tblVwList?.tintColor = UIColor.ThemeGradientStart()
        self.tblVwList?.tableFooterView = UIView()
        self.tblVwList?.separatorStyle = .none
        self.tblVwList?.allowsMultipleSelection = false
        self.tblVwList?.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 40.0, right: 0.0)
    }
    
    // Setting Up Default Data
    func setUpDefaultData() {
        self.lblTitle?.text = "Ready, Set, Cook\nMaster Our Exclusive Recipes Today !"
    }
    
    //MARK: -------- Web Services Api Call --------
    
    private func callAPIToGetRecipesList() {
        
        guard let url = URL(string: RECEIPE_END_POINT_URL) else {
            print("Invalid URL")
            return
        }
        
        DispatchQueue.main.async {
            self.activityIndicator?.startAnimating()
        }
        
        NetworkManager.shared.request(url, method: .get) { (result: Result<RecipeResponse, Error>) in
            switch result {
            case .success(let response):
                self.arrRecipes = response.recipes
                DispatchQueue.main.async {
                    self.activityIndicator?.stopAnimating()
                    self.tblVwList?.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch recipes: \(error)")
                DispatchQueue.main.async {
                    self.activityIndicator?.stopAnimating()
                }
            }
        }
    }
    
}


//MARK: -------- Table View DataSource and Delegate --------

extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.arrRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeMenuCell", for: indexPath) as? HomeMenuCell else { return UITableViewCell() }
        
        let log = self.arrRecipes[indexPath.row]
        cell.configureCellWith(log)
    
        return cell
 
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
