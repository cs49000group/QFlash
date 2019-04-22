# QFlash

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Allows for the user to answer quiz questions in a classroom setting both open ended and free response.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:Education Application**
- **Mobile:Studnets can answer questions on their mobile phones**
- **Story:This application allows for students to answer open ended or multiple choice questions at no expense to them which is not allowed an any similar form of software**
- **Market: students and faculty at colleges or universities**
- **Habit: Used once or twice within a class period**
- **Scope:Anyone who needs to take attendence or ask questions within a classroom or a professional setting**

##Product Spec
## 1. User Stories (Required and Optional)

**Required Must-have Stories**

 * User can create an account
 * User can login
 * User can view their account info
 * User can create a quiz
 * User can select a quiz
 * User can answer quiz questions
 * User can see quiz results

**Optional Nice-to-have Stories**

 * Graph of correct and incorrect answers
 * Automatically correcting answers for open ended questions
 * Allow for matching quizes
 * Allow for images to be used as answers

## 2. Screen Archetypes

 * Login 
     * User can login
 *  Register
     * User can create an account
 * Stream
     * User can see quiz results
 * Detail
     * User can select a quiz
     * User can answer quiz questions
 * Creation
     * User can create a quiz
 * Profile
     * User can make a student or user profile
 * Settings
     * User can manipulate what classes they are a part of

## 3. Navigation

**Tab Navigation** (Tab to Screen)

 * Tab Navigation
     * Class Feed
     * Profile
     * Settings

**Flow Navigation** (Screen to Screen)

 * login screen
     * =>Home
 * registration screen
     * =>Home
 * Class feed
     * =>Class Page
         * =>Quizzes
             * =>Answer questions
     * =>Create class
         * Enter class name and Invite students 
 * Profile
     * =>None
 * Setting 
     * =>None

![](https://github.com/cs49000group/QFlash/blob/master/Wireframe.jpeg)

## 4. Schema

**Models**


| Property | Type     | Description            |
| -------- | -------- | -----------------------|
| classId  | String   | unique id for the class|
| quizId   | String   | unique id for the quiz |
| userId   | String   | unique id for the user |
| createdAt| DateTime | date when the quiz is created|
| releasedAt| DateTime| date/time when the quiz is released|
| closedAt| DateTime| date/time when the quiz is closed|
| answerCount | Number| number of answer choices|
| quizCount | Number| number of quizzes within a class|
| classCount| Number| number of classes |
| updatedAt| DateTime| date when the quizzes are updated|
| studentCount| Number| number of students enrolled in a class|

**Networking**

* Login screen
    * (Read/GET) gets user password information
     ```{}        
      let query = PFQuery(className:"user")
        query.whereKey("userId", equalTo: currentUser)
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (users: [PFObject]?, error: Error?) in
       if let error = error { 
          print(error.localizedDescription)
       } else if let users = users {
          print("Successfully retrieved \(users.count) users.")
      // TODO: Do something with users...
       }
        }
    ```
    * (Update/PUT) updates new users
     ```{}        
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { (sucess, error) in
            if sucess {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription )")
            }
        }
        
* Class Feed Screen
    * (Read/GET) gets all classes where user is enrolled
        ```{}        
      let query = PFQuery(className:"class")
        query.whereKey("userId", equalTo: currentUser)
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (classes: [PFObject]?, error: Error?) in
       if let error = error { 
          print(error.localizedDescription)
       } else if let classes = classes {
          print("Successfully retrieved \(classes.count) classes.")
      // TODO: Do something with classes...
       }
        }
        ```

    * (Delete/DELETE) delete a class where user is enrolled
        ```{}        
        var query = PFQuery(className:"class")
        query.whereKey("userId", equalTo: "\ (PFUser.currentUser()?.userID)")
        query.whereKey("classID", equalTo: "\(classField.text!)")

        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                for object in objects as! [PFUser] {
                    object.deleteInBackground()
                }
            } else {
                println(error)
            }
        }
        ```
* Quiz Feed Screen
    * (Read/GET) gets all quizzes within the class
      ```{}        
      let query = PFQuery(className:"quiz")
        query.whereKey("userId", equalTo: currentUser)
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (quizes: [PFObject]?, error: Error?) in
       if let error = error { 
          print(error.localizedDescription)
       } else if let quizes = quizes {
          print("Successfully retrieved \(quizes.count) quizes.")
      // TODO: Do something with quizes...
       }
        }
        ```
* Quiz Screen
    * (Read/GET) gets the question/answer choices
     ```{}        
      let query = PFQuery(className:"answer")
        query.whereKey("userId", equalTo: currentUser)
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (answers: [PFObject]?, error: Error?) in
       if let error = error { 
          print(error.localizedDescription)
       } else if let answers = answers {
          print("Successfully retrieved \(answers.count) answers.")
      // TODO: Do something with answers...
       }
        }
    ```
    * (Update/PUT) updates the user's answer
    ```{}
    let query = PFQuery(className:"answer")
        query.includeKeys(["user", "questions", "questions.author"])
        query.findObjectsInBackground { (answers, error) in
            if answers != nil {
                self.answers = answers!
                self.reloadData()
            }
        }
    ```
* Profile Screen
    * (Read/GET) gets the user's profile information
     ```{}        
      let query = PFQuery(className:"user")
        query.whereKey("userId", equalTo: currentUser)
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (users: [PFObject]?, error: Error?) in
       if let error = error { 
          print(error.localizedDescription)
       } else if let users = users {
          print("Successfully retrieved \(userss.count) users.")
      // TODO: Do something with users...
       }
        }
        ```
* Create Class Screen
    * (Create/POST) updates the classes
           
        ```{}
        let class = PFObject(className: "class")
        
        class["class"] = classField.text!
        class["author"] = PFUser.current()!
        
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved")
            } else {
                print("error!")
            }
        } 
        ```
* Create Quiz Screen
 
    ```{}
    let quiz = PFObject(className: "quiz")
        
    quiz["answer"] = answerField.text!
    quiz["author"] = PFUser.current()!
        
    quiz["a1"] = a1Field.text!
    quiz["a2"] = a2Field.text!
    quiz["a3"] = a3Field.text!
        
    quiz["multiple"] = choiceField.text!
        
    post.saveInBackground { (success, error) in
        if success {
            self.dismiss(animated: true, completion: nil)
            print("saved")
        } else {
            print("error!")
        }
    }
    ```
* Settings Screen
    * (Update/PUT) updates user's personal settings
    ```{}        
        let firstname = firstname.text 
        let lastname = lastname.text
        let username = username.text
        
        var user = PFUser.currentUser()!
        
        user["username"] = username
        
        user.saveInBackground()
        
        //TODO update profile picture
    ```


    * (Delete/DELETE) deletes the user's account
        ```{}        
        var query = PFQuery(className:"user")
        query.whereKey("userId", equalTo: "\ (PFUser.currentUser()?.userID)")

        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                for object in objects as! [PFUser] {
                    object.deleteInBackground()
                }
            } else {
                println(error)
            }
        }
        ```
        
        
 ## Milestone 1
   - [x] Build UI Navigation
   - [x] Create Parse Server
   - [x] Implement Login and Logout
   - [x] Create a class and store it in the server
    
  ## Milestone 1 Walkthrough
    
   <img src='https://github.com/cs49000group/QFlash/blob/master/Milestone1_demo.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
   
  ## Milestone 2
  - [x] Join Class
  - [x] Display Classes in table view
  - [x] Create Quiz
  - [x] Display Quizzes in table view
 
 ## Milestone 2 Walkthrough
 <img src='https://github.com/cs49000group/QFlash/blob/master/Milestone2_demo.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
 
 ## Milestone 3
 - [x] Open Quiz in App
 - [x] Take Quiz in App
 - [x] Sort Quizzes by class

## Milestone 3 Walkthrough
 <img src='https://github.com/cs49000group/QFlash/blob/master/Milestone3_demo.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
 
 ## Milestone 4
 - [x] settings page
 - [x] profile page
 - [x] results page
 
 ## Milestone 4 Walkthrough
 <img src='https://github.com/cs49000group/QFlash/blob/master/Milestone4_demo.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

