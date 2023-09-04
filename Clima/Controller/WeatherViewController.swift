
import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
  
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchField: UITextField!
    
    
    var weathermanager = WeatherData()
    let locationManager = CLLocationManager()
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
      
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weathermanager.delegate=self
        searchField.delegate=self
           
    }

 
}

//MARK: - weatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate{
    
      func didUpdateWeather(_ weatherManager: WeatherData, weather: weatherModel)  {
          DispatchQueue.main.async {
              
              self.temperatureLabel.text = weather.temperatureString
              self.conditionImageView.image = UIImage(systemName: weather.ConditionName)
              self.cityLabel.text = weather.cityName
        
          }
      }
      func didFailWithError(error: Error) {
         print(error)
      }
    
}

//MARK: - UitextFieldDelegate

extension WeatherViewController: UITextFieldDelegate{
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchField.endEditing(true)
        print(searchField.text!)
         
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        print(searchField.text!)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchField.text {
            weathermanager.fetchWeather(cityName: city)
        }
        
        searchField.text = ""
        
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchField.text != ""{
            return true
        }else{
            searchField.placeholder = "type something"
            return true
        }
    }
}
 //MARK: - CLLocation

extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.startUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weathermanager.fetchWeather(latitude:lat, longitude:lon )
        }
         
    }
    @IBAction func locationButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

 
