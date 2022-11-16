# TailTogether

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
This application allows users to chat with eachother on upcoming venues to meet new friends that have similar interest , have a pregame party, or just talk about the event

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Social Networking
- **Mobile:** This app will be started with mobile with the possibility of expanding to web base for computers
- **Story:** Allows a user to make an event from small as a party to a concert or football games. Then other users can say they are going then may chat about the event for rideshare, outfit coordination, or tips/hacks
- **Market:** Any individual can use the application as it is based on venues they prefer
- **Habit:** A individual can use this app as much as they want to meet new friends before the venue
- **Scope:* We would start this application for small groups to get together before their favorite venue. Then potentially expand to venue organizers like livenation or football stadiums

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x]User logs in to access the applicaiton
- Profile page for the user
- Events that users can join
- Allowing an individual to make an event
- Direct messaging to an individual

**Optional Nice-to-have Stories**

- Matching venues to a users interest from their current venues
- Matching users to other usesers with similar intrests

### 2. Screen Archetypes

* Login/Register - User signs up or logs into their account
   * When a user is not logged in, they are prompted to login or sign up for the application.
* Upcoming Event Screen - Upcoming events
   * All events that are upcoming that a user can join to start messaging about the event
* Event planning Screen 
    * Allows a user to make their own event
* My Event Screen 
    * Current events the user is already in 
* Messaging Screen - Chat for users (direct 1 on 1)
    * Allows individual users to chat with eachother 
* Profile Screen 
    * Allows the user to add a picture of themselves with a bio of their intrests

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Profile
* My Events
* Upcoming Events
* Plan an event
* Chats

**Flow Navigation** (Screen to Screen)

* Login/Registed -> User logs in automatically if signed in
* Upcoming events -> If user chooses an event its added to my Events
* My Events -> Chat to users or in the group
* Plan an event -> Adds to My Events
* Profile -> Add a photo or edit bio

## Wireframes
![Wireframes](https://user-images.githubusercontent.com/98677021/199378128-0fb9d072-7f87-47ce-bc30-177f042d401b.png)



## Schema 

### Models
#### Post

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
   | author        | Pointer to User| image author |
   | image         | File     | image that user posts |
   | eventTitle    | String   | event the user is posting |
   | eventDesc     | String   | description of the event |
   | createdAt     | DateTime | date when event post is created (default field) |
   | updatedAt     | DateTime | date when event post is last updated (default field) |
   
### Networking
- [Add list of network requests by screen ]

#### List of network requests by screen
   - Home Feed Screen
      - (Read/GET) Query all events where user is author
         ```swift
         let query = PFQuery(className:"Events")
         query.whereKey("author", equalTo: currentUser)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let events = events {
               print("Successfully retrieved \(events.count) events.")
           // TODO: Do something with events...
            }
         }
         ```
      - (Create/POST) add current user to event
      - (Delete) delete current user to event
      
   - Create events Screen
      - (Create/POST) Create a new event object
   - My Events Screen
      - (Delete) delete events 
   - Profile Screen
      - (Read/GET) Query logged in user object
      - (Update/PUT) Update user profile image

