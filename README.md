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

Declare the variable -  dispatchGroup and  implement dispatchGroup enter and leave in completion handler, to make sure all data will settle down before reloading.

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

Use the semaphore to control the task sequence. Set the wait semaphore before the task function called. The semaphore will only give the green light in the completion handler while the process completed. In this case, the task will proceed after the previous work done.

``` swift 
let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

....
self.semaphore.signal()

}

self.semaphore.wait()
dataTask.resume()    

```
