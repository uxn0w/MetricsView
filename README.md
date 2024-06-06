# MetricsView [![version](https://img.shields.io/badge/version-1.0.0-white.svg)](https://semver.org)
UI component representing a set of metrics for analyzing the performance of your application.

<img src="./Resources/Preview.gif" alt="preview" width="350"/>

## Getting Started

### Requirements
- **Platform:** iOS 13 or later
- **Swift version:** Swift 5.x or later

### Installation

#### Swift Package Manager
To include MetricsView into a Swift Package Manager package, add it to the `dependencies` attribute defined in your `Package.swift` file. You can select the version using the `majorVersion` and `minor` parameters. For example:
```ruby
dependencies: [
  .Package(url: "https://github.com/uxn0w/MetricsView.git", majorVersion: <majorVersion>, minor: <minor>)
    ]
```

### Usage

#### With MetricsWindow
When configure this way, the metric view will always be on top of the other views.
1. Go to SceneDelegate/scene(_ scene:, willConnectTo session:, options connectionOptions:)
2. Create MetricsWindow 
```swift 
let metricsWindow = MetricsWindow(windowScene: windowScene)
```
3. Set metrics
```swift
metricsWindow.metrics = [.cpu, .fps, .hitches, .memory]
```
4. Set window

#### With MetricsView

1. Create MetricsView
```swift 
let metricsView = MetricsView()
```
2. Set metrics
```swift
metricsView.metrics = [.cpu, .fps, .hitches, .memory]
```
3. Add metrics view to your subview
