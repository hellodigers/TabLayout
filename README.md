# TabLayout
[![Version](https://img.shields.io/cocoapods/v/TabLayout.svg?style=flat)](http://cocoapods.org/pods/TabLayout)

TabLayout is a View that allows us to switch view controller. 

## Screenshots

![gif](http://i.imgur.com/lOMhYSj.gif)

## Installation

### Manually

Copy TabLayout.swift to your project.

### Cocoapods #TODO

## Demo

To run the example project, clone the repo, and run pod install from the Example directory first.

## Usage

### With icon and title
```
 @IBOutlet var tabLayout: TabLayout!
 tabLayout.addTabs(tabs: [
            ("First", UIImage.init(named: "ic_favorite"), firstViewController),
            ("Second", UIImage.init(named: "ic_verified_user"), secondViewController),
            ("Third", UIImage.init(named: "ic_favorite"), thirdViewController)
            ])
```
### Without icon
```
 @IBOutlet var tabLayout: TabLayout!
 tabLayout.addTabs(tabs: [
            ("First", nil, firstViewController),
            ("Second", nil, secondViewController),
            ("Third", nil, thirdViewController)
            ])
```
![fixedimage](http://i.imgur.com/0AQlYsy.png)
### Without title
```
 @IBOutlet var tabLayout: TabLayout!
 tabLayout.addTabs(tabs: [
            (nil, UIImage.init(named: "ic_favorite"), firstViewController),
            (nil, UIImage.init(named: "ic_verified_user"), secondViewController),
            (nil, UIImage.init(named: "ic_favorite"), thirdViewController)
            ])
```
![withouttitle](http://i.imgur.com/OkXYp5s.png)
### Fixed mode
```
 @IBOutlet var tabLayout: TabLayout!
 tabLayout.fixedMode = true
 tabLayout.addTabs(tabs: [
            (nil, UIImage.init(named: "ic_favorite"), firstViewController),
            (nil, UIImage.init(named: "ic_verified_user"), secondViewController)
            ])
```
![fixedmode](http://i.imgur.com/OkXYp5s.png)
## Author

Digers, bartosz.kozajda@dige.pl

## License

TabLayout is available under the MIT license. See the LICENSE file for more info.
