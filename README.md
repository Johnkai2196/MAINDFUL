# MAINDFUL

*"Harness the potential of AI for a healthier you — Because better health is just a chat away"*

## Project Description
Maindful is a project carried out by group of Metropolia UAS students as a part of their studies. Maindful allows the user to interact with their health data stored in their smartphones health application through OpenAI's LLM.
Maindful is supported only on iOS devices.
  
## Features

* Conversational user-interface for easy health-data interaction through natural language
* Apple Health-data integration for strainghtforward data-usage. Currently the application supports Heart Rate, VO2MAX, Sleep and steps.
* Pre-made prompts
* Support for open questions regarding users health data. 
* Short-analysis on KPI pages 
* Simple and user-friendly UI

## UI

<img src="https://github.com/Johnkai2196/innovation_project/assets/73104201/b2ac87e8-67c9-4c9d-a3b6-680938ba43be" alt="Main Chat" width="300">

<img src="https://github.com/Johnkai2196/innovation_project/assets/73104201/168a5070-c088-4523-a8ba-82b3e841147c" alt="KPI Pages" width="300">

<img src="https://github.com/Johnkai2196/innovation_project/assets/73104201/1f92b82d-1e37-4836-aa49-1dbb16145d71" alt="Chat Pages" width="300">

## Disclaimer
MAINDFUL is provided for general informational purposes only and is not intended as a substitute for professional medical advice, diagnosis, or treatment. Large language models, such as those provided by OpenAI, are known to hallucinate and at times return false information. The use of MAINDFUL is at your own risk. Always consult a qualified healthcare provider for personalized advice regarding your health and well-being. Aggregated HealthKit data for the past 7 days will be uploaded to OpenAI.  Your data will be preserved for 30 days by OpenAI. Your data will not be used to train the AI models of OpenAI. Please refer to the OpenAI [privacy policy](https://openai.com/policies/privacy-policy) for more information.

## Setup
**FOR NON-MAC USERS**

**Step 0.** You need to have flutter installed in your computer. Guide on how to install flutter in [here](https://docs.flutter.dev/get-started/install).

**Step 1.** Clone this repository
```bash
git clone https://github.com/Johnkai2196/innovation_project
```

**Step 2.** Open the repository in your software development environment.

**Step 3.** Create a .env file inside lib folder.

**Step 4.** Inside the .env file write: TOKEN = [YOUR OPENAI API-KEY]. OpenAI's API keys can be generated from their website. 

**Step 5. (NON-MAC USERS ONLY)** Run the following commands in your terminal and enjoy the application!: 
```bash
flutter pub get
```
```bash
flutter run
```
**Step 5.1 (MAC USERS ONLY)** Run the following command in your terminal:
```bash
flutter pub get
```
**Step 5.2 (MAC USERS ONLY)** Open XCode and the ios folder of the repository in XCode.

**Step 5.3 (MAC USERS ONLY)** Click the Runner.

**Step 5.4 (MAC USERS ONLY)** Select Signing & Capabilities on the top-bar of the window.

**Step 5.5 (MAC USERS ONLY)** For the following step, a Apple developer account is required. You can create one for free on Apple's website.

**Step 5.6 (MAC USER ONLY)** Select Personal Team as your team from the dropdown-menu.

**Step 5.7 (MAC USERS ONLY)** Add HealthKit through Capabilites.

**Step 5.8 (MAC USERS ONLY)** Run the following command in your terminal and enjoy the application!: 
```bash
flutter run
```

## Authors

[Johnkai Cortez](https://github.com/Johnkai2196 "Johnkai Cortez"), [Jenna Hakulinen](https://github.com/jennahakulinen "Jenna Hakulinen"), [Andreas Greenberg](https://github.com/AndyGreenie "Andreas Greenberg") and [Kata Sara-aho](https://github.com/kvtvs "Kata Sara-aho")

## License

This project is licensed under the MIT License. See [Licenses](https://github.com/Johnkai2196/innovation_project/blob/main/LICENCE.txt) for more information.
