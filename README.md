# AI-Mobile-Performance-Monitor-Application

## Table of Contents

- [Introduction](#introduction)
- [AI Model and Development](#ai-model-and-development)
- [Features](#features)
- [Technology Used](#technology-used)
- [Steps to Run the Project](#steps-to-run-the-project)

## Introduction

This application empowers users to gain real-time insights into their mobile device's performance and engage in insightful conversations with an AI model for deeper investigation. It provides a user-friendly interface for monitoring key metrics such as battery level, storage usage, memory consumption, and network activity.

## AI Model and Development

This application utilizes a hybrid approach for its AI functionality, leveraging both offline and online capabilities.

**Offline Mode:**

- **Model:** The offline mode utilizes a quantized version of the **Gemma** model, specifically a **Gemma-2B"** model.
- **Quantization:**  The model has been quantized to 4 bits to optimize its size and performance for mobile environments.
- **Download Link:** **https://www.kaggle.com/models/google/gemma/tfLite/gemma-2b-it-cpu-int4** 

**Online Mode:**

- **Integration:** For online functionality, the application integrates with the **OpenAI API**, allowing access to a more powerful and up-to-date AI model.
- **Model:** The online mode utilizes the **GPT-4-mini** API, which provides a more advanced and feature-rich AI experience.

**Development:**

- **Framework:** The mobile application is built using the Flutter framework, providing a robust and efficient solution for Android devices.

By combining offline and online capabilities, this application provides a user experience with both immediate responses and access to the latest AI advancements.

## Features

- **Real-time Performance Monitoring:** Track battery level, storage usage, memory consumption, and network activity in real-time.
- **AI-Powered Insights:** Get personalized insights and predictions about your device's performance from an AI model. 
- **Offline Mode:** Access basic performance monitoring even when you are not connected to the internet.
- **User-Friendly Interface:** Navigate the application with ease.

## Technology Used

- **AI Model:** [Gemma-2B-int4] 
- **OpenAI API:** For online AI interactions 
- **Flutter Framework:** Cross-platform mobile development framework 


## Steps to Run the Project

This section will walk you through the process of running the application.

1. **Download the AI Model:** Download the quantized AI model from **https://www.kaggle.com/models/google/gemma/tfLite/gemma-2b-it-cpu-int4**. 
2. **Add to Assets:** Place the downloaded model.bin file in the `assets` folder within your application's project directory.
3. **Update Pubspec.yaml:**
   - Navigate to the `pubspec.yaml` file in your project.
   - Add the `assets` section to include the model file:

     ```yaml
     flutter:
       assets:
         - assets/
     ```
4. **Install Dependencies:** Run `flutter pub get` to install any necessary dependencies.
5. **Run the Application:** Execute `flutter run` to start the application.
   
**Important**: The model is stored in the system files and is loaded only once during installation. You do not need to reload it every time you start the application.
