# Iris.iOS
![License: MIT](https://img.shields.io/github/license/Neko3000/Iris.iOS)
![Platforms: iOS](https://img.shields.io/badge/Platform-iOS-lightgrey)
![Language: Swift](https://img.shields.io/badge/language-swift-orange.svg)
![Version: v0.90](https://img.shields.io/badge/version-v0.90-lightgrey)

Iris is a model mobile application based on iOS.</br>
It provides basic functions allow users to explore on [DeviantArt](https://www.deviantart.com/) and check Daily Arts, Notifications, Deviation Collections...</br>
</br>
All contents are delivered by [DeviantArt API](https://www.deviantart.com/developers/).</br>

## Installation
Simple clone it by:

```
$ git clone https://github.com/Neko3000/StarryTarget.git
```

Open it, hit <kbd>command</kbd> + <kbd>R</kbd>,</br>
Done!

## How to use
<p align="center"> 
<img width="300" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/starrytarget-sr1.gif" alt="screen-record-1">
<img width="300" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/starrytarget-sr2.gif" alt="screen-record-2">
</p>

<p align="center"> 
<img src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/starrytarget-s1.png" width="200" alt="">
<img src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/starrytarget-s2.png" width="200" alt="">
<img src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/starrytarget-s3.png" width="200" alt="">
<img src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/starrytarget-s4.png" width="200" alt="">
</p>

## Features
- [x] Sign IN / Sign UP
- [x] Daily Art
- [x] Explore - Popular, Newest, Undiscovered
- [x] Deviation Detail
- [x] Notification
- [x] Gallery
- [x] Joural
- [x] Status
- [x] Collection (Featured)
- [x] Follower
- [x] Profile Comment
- [x] More...

## Interface Design
We fully customized its interface considering proper UX before we developed it on Xcode.</br>
And we decided to provide its Sketch file, you could find it here.

## Dependencies
For handling Network requests, we used famouse [Alamofire](https://github.com/Alamofire/Alamofire) and [SwfityJSON](https://github.com/SwiftyJSON/SwiftyJSON) in this project.</br>
And we also used some fantastic UI controls, likes [TwicketSegmentedControl](https://github.com/twicketapp/TwicketSegmentedControl), [NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView)...

Pods have been included:

```
pod 'RxSwift'
pod 'RxCocoa'
pod 'RealmSwift'
```

## Development
You should use your own Applications Keys (client_id & client_secret), please refer to [Doc of DeviantArt API](https://www.deviantart.com/developers/apps) to check the authentication details.

Here's the path:
```
// RealmManager.swift
print(Realm.Configuration.defaultConfiguration.fileURL!)
```

## Contact To Me
E-mail: sheran_chen@outlook.com </br>
Weibo: @妖绀

## Contributers

## License
Distributed under the MIT license. See LICENSE for more information.
