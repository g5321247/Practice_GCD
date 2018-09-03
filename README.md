# GCD Test

GCD is a thread control tool written in Swift.

* [Features](#readme)
* [Method](#readme)

## Features

+   **Fetch**

    Fetch Data from the Internet and display it by order   

## Method 

+   **Group**
+   **Semaphore**
+   **DeadLock**
+   **Deadlock Prevention**

### 1. Group

Declare the variable -  dispatchGroup and  implement dispatchGroup enter and leave in completion handler, to make sure all data will settle down before reloading it.

``` swift
let dispatchGroup = DispatchGroup()

dispatchGroup.enter()

let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

......

guard let response = response as? HTTPURLResponse else {               

......

self.dispatchGroup.leave()

}


``` 

It will notify us once all the process finished.

``` swift
self.dispatchGroup.notify(queue: .main){

self.onlineData.append(result)

self.tableView.reloadData()

}


```

### 2. Semaphore

<!--Use Notification to post data from SecondViewController 

``` swift 
NotificationCenter.default.post(name: .edit, object: inputTxtView.text)
NotificationCenter.default.post(name: .add, object: inputTxtView.text)

```

Create observers receiving post

``` swift
NotificationCenter.default.addObserver(self, selector: #selector (getDataFrom(_:)), name: .edit, object: nil)
NotificationCenter.default.addObserver(self, selector: #selector (getDataFrom(_:)), name: .add, object: nil)

```
-->
