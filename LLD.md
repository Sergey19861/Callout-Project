# Salesforce Technical  Design

## Functional Module: Callout Executor

### Technical Design Specification

#### DOCUMENT INFORMATION AND APPROVALS

***

##### Version History

| Version # |    Date    |      Author       |     Reason for Change     |
|:---------:|:----------:|:-----------------:|:-------------------------:|
|    0.1    | 29.06.2022 | Sergey Krivorotov | Creation of functionality | 


***

### 1. Overview

This functionality is designed to give developers a tool to create different types of callouts.
This project also contains the logic for callouts execution and logs creation.

- **Purpose and Audience**

This functionality is designed to simplify and generalize the creation and execution of callouts.

- **Supporting Project References**

[Git Hub](https://github.com/Sergey19861/Callout-Project)

***

### 2. Business UseCase
- The project has a class that shows how to perform callouts to an external system.
- The project has a class that shows how to log in to a Salesforce org and create an Account record using callouts.

***

### 3. Design Overview

- **Entity Relationship Diagram**

  ![Project Diagram](/images/CalloutProjectDiagram.jpg)

***

### 4. Objects Definition and Configuration

- **Picklist Value Set**

No new global picklists were introduced to implement this feature.

- **Standard Objects**

No changes have been delivered for this implementation

- **Custom Objects**

|       Name        |     API name      |     Type      |                Access                |
|:-----------------:|:-----------------:|:-------------:|:------------------------------------:|
| Integration Log   | IntegrationLog__c | Custom Object | Callout Integration (permission set) |

***

### 5. Security Setup

- **Profiles**

There are no new profiles introduced for this feature.

- **Permission Sets**

|    Permission Set    | License Type |          Description (Access and assignment)          |
|:--------------------:|:------------:|:-----------------------------------------------------:|
| Callout Integration  |     None     | Uses to give access to Callout Executor functionality |

- **Sharing Settings**

No changes in sharing setting related to any object as part of this feature.

***

### 6. User experience

To use this functionality, extend the Callout class then override buildRequestBody(), parseResponse(String response)
and Type getType() methods with your logic inside.

***

### 7. Standard Setup Configurations

- **List View Change**

No changes in List View related to any object as part of this feature.

***

### 8. Custom Setup Configurations

No changes in Custom Setup Configurations as part of this feature.

***

### 9. Apex Business Logic

| Name                   | Type            | Description                                                                       |
|:-----------------------|:----------------|:----------------------------------------------------------------------------------|
| Callout                | Apex Class      | Parent class for all Callouts.                                                    | 
| CalloutExecutor        | Apex Class      | Designed to execute callout and log creation.                                     |
| CalloutExecutorTest    | Unit Test Class | Contains test logic for CalloutExecutor.                                          |
| CalloutMethodConstants | Apex Class      | Contains constants for callout method.                                            |
| CalloutRates           | Apex Class      | Designed to integrate org with www.floatrates.com.                                |
| CalloutSFCreateSObject | Apex Class      | Co ntains logic for creating SObjects of different type(with fields and values).  |
| CalloutSFLogin         | Apex Class      | Designed to login in Salesforce Scratch org and get sessionId.                    |
| MockFactory            | Apex Class      | Created to mock Http Callout Response.                                            |
| SalesforceService      | Apex Class      | Designed to create records of sObjects of various types using the SOAP protocol.  |

***

### 10. Lightning Components

No new Lightning Components were introduced to implement this feature.

***

### 11. Destructive Changes

List of classes, components, fields, objects, rule and other entities which were deleted during work on Epic/Feature.

***

### 12. Review and Sign Off

- **DOCUMENT REVIEWS**


- **DOCUMENT APPROVALS**
 
