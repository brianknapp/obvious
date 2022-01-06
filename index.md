<iframe width="560" height="315" src="https://www.youtube.com/embed/hxDDjVRUP1I" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

# Welcome To Obvious

Obvious is an architecture framework. The goal is to provide architectural structure for a highly testable system that is obvious to understand and where both the front end UI and back end infrastructure are treated as implementation details independent of the app logic itself.

## Design Principles

- Obvious Functionality
- Framework Independence
- Extreme Testability
- Maintenance Minded

### Obvious Functionality

When looking at the app directory, it should be obvious what kinds of things the application does. This architecture highly values the "glance factor" of the application structure as well as being obvious in where to find things while working with the project.

### Framework Independence

Your application does not need to be a web app, api app, desktop app, or console app. It also doesn't need to be a MySQL, MongoDB, or SQLServer app. Your app is just a set of data structures and functionality related to those data structures. How your app delivers your app or stores data are implementation details.  

Implementation details can and should change based on your implementation needs, your app logic shouldn't have to change when your implementation requirements do.

### Extreme Testability

This is a TDD biased structure. Each layer and pattern is designed with testing in mind. More importantly, we designed this architecture so that testing would be easier for developers, which should lead to more testing and better software quality.

### Maintenance Minded

When given the choice between short term productivity or long term maintenance, we believe that the right decision is long term maintenance. Many decisions have been made that are counterintuitive from a short term productivity standpoint, but allow for much easier maintenance. Obviousness, framework independence, and testability all work together to make the day to day maintenance more enjoyable.

## Structure

There are three well defined folders of each project, which define the three core divisions of a given project - app, delivery, and external.

### App

App is where the core entities, actions, and data contracts of your application are housed.

#### Entities

Entities represent data in your system. They are fairly dumb data structures that mostly just contain data and do validation on the data they contain.

#### Actions

Actions are the use cases of the system.


#### Contracts

Contracts define the data transport structures and perform format validation on the hashes.

### Delivery

Delivery is where you implement the delivery mechanism of your application itself.  This means in simplest terms the UI, but it also means creating concrete versions of the external objects, such as data gateways, and also calling the actions of the app itself.

### External

External is where data transport between your app and various external infrastructure lives. This could be datbases, queues, or caching layers connected to various data systems such as Redis, MongoDB, MySQL, the filesystem etc.

## Data Transport

The fundamental data structure of data transport is going to be a hash. This is for both incoming and outgoing data from the action layer.  The reason for this is simply to keep the app logic from creeping outside of the app into the external layer or the ui layer. If we send dumb data between layers, it would be impossible to call Entity methods from a view as the Action objects return hashes, and not entity objects.
