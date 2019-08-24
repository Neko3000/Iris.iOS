# Iris.iOS
![License: Mozilla](https://img.shields.io/github/license/neko3000/iris.ios)
![Platforms: iOS](https://img.shields.io/badge/Platform-iOS-lightgrey)
![Language: Swift](https://img.shields.io/badge/language-swift-orange.svg)
![Version: v0.70](https://img.shields.io/badge/version-v0.70-lightgrey)

Iris is a model mobile application based on iOS.</br>
It provides basic functions allow users to explore on [DeviantArt](https://www.deviantart.com/) and check Daily Arts, Notifications, Deviation Collections, etc.</br>
</br>
All contents are delivered by [DeviantArt API](https://www.deviantart.com/developers/).</br>

## Installation
Simple clone it by:

```
$ git clone https://github.com/Neko3000/Iris.iOS.git
```

Open it then hit <kbd>command</kbd> + <kbd>R</kbd>, Done!

## How to use
<p align="center"> 
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/iris-ios-sr1.gif" alt="screen-record-1">
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/iris-ios-sr2.gif" alt="screen-record-2">
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/iris-ios-sr3.gif" alt="screen-record-3">
</p>

<p align="center"> 
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/iris-ios-s1.png" alt="screenshot-1">
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/iris-ios-s2.png" alt="screenshot-2">
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/iris-ios-s3.png" alt="screenshot-3">
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/iris-ios-s4.png" alt="screenshot-4">
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/iris-ios-s5.png" alt="screenshot-5">
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/iris-ios-s6.png" alt="screenshot-6">
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/iris-ios-s7.png" alt="screenshot-7">
<img width="200" src="https://raw.githubusercontent.com/Neko3000/resource-storage/master/img/screenshot/iris-ios-s8.png" alt="screenshot-8">
</p>

## Features
- [x] Sign IN / Sign UP
- [x] Daily Art
- [x] Explore - Popular, Newest, Undiscovered
- [x] Deviation Detail
- [x] Notification
- [x] Gallery
- [x] Journal
- [x] Status
- [x] Collection (Featured)
- [x] Watcher
- [x] Profile Comment
- [ ] Submit Art
- [ ] Update Profile
- [X] More...

## Interface Design
We fully customized its interface considering proper UX before we developed it on Xcode.</br>
And we decided to provide its Sketch file, you could find it on [Iris.iOS on Behance](https://www.behance.net/gallery/84568283/IrisiOS).

## Dependencies
For handling Network requests, we used famouse [Alamofire](https://github.com/Alamofire/Alamofire) and [SwfityJSON](https://github.com/SwiftyJSON/SwiftyJSON) in this project.</br>
And we also used some fantastic UI controls, likes [TwicketSegmentedControl](https://github.com/twicketapp/TwicketSegmentedControl), [NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView)...

Pods have been included:

```
pod 'Alamofire', '5.0.0-beta.7'
pod 'SwiftyJSON', '~> 4.0'
pod 'TwicketSegmentedControl'
pod 'NVActivityIndicatorView'

```

## Development
We provided client_id and secret_key for testing in files. But you should use your own Applications Keys (client_id & client_secret), please refer to [Doc of DeviantArt API](https://www.deviantart.com/developers/apps) to check the authentication details.</br>

Those key values could be found here:

```
// ApplicationKey.swift
static let clientKey = "XXXX"
static let secretKey = "XXXXXXXXXXXXXX"
```

## Contact To Me
E-mail: sheran_chen@outlook.com </br>
Weibo: @妖绀

## Contributers
Artists on DeviantArt.com:</br>
[pikaboots](https://www.deviantart.com/pikaboots/art/ahri-396860694)</br>
[NeoArtCorE](https://www.deviantart.com/neoartcore/art/Ahri-516972803)</br>
[MOYAILRIS](https://www.deviantart.com/moyailris/art/Ahri-355382339)</br>
[arseniquez](https://www.deviantart.com/arseniquez/art/Ahri-601141096)</br>
[NPye13](https://www.deviantart.com/npye13/art/Ahri-594746695)</br>

## License
Distributed under the Mozilla license. See LICENSE for more information.
