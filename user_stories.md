# User Stories

Break down the app's functionality into manageable, user-focused tasks that guide development.
Organize user stories with labels to help you quickly identify their purpose and priority. 

- Login/registration page (allows users to register with their details or log in with their credentials)
    Account registration
        As a user, I want to register with my name, username, age, and country so that I can create an account and access the habit tracking features.
    Account login
        As a user, I want to log in using my username and password so that I can access my account and track my habits.
    Store user data 
        User details will be saved in local storage so that the data persists between app sessions.
        Automatically re-login users with saved login when app re-opens, unless explicitly signed out.
            login state to persist across sessions
            (backend? hashing password? localStorage stores hashed creds?)
    Error feedback on login
        As a user, I want to receive a message if I enter the wrong username or password so that I know my login attempt was unsuccessful.
- Homepage (an overview of the user's progress and a welcome message)
    View welcome message
        As a user, I want to see a personalized welcome message with my name on the homepage, so that I feel recognized and can confirm I am logged into the correct account.
    Display weekly progress
        As a user, I want to see my daily progress for each habit on the homepage, so that I can easily monitor my progress.
    View completed habits
        As a user, I want to see a section for completed habits on the homepage, so that I can track what I have already achieved.
- Tasks\Habits
    Add a new habit
        As a user, I want to add new habits on the details configuration page so that I can manage and update my habits as needed.
    Delete a habit
        As a user, I want to delete existing habits so that I can keep my habits up to date.
    Personalize a habit with color
        As a user, I want to assign a specific color to each habit to make it personal to me.
- Detailed screen (briefly describes the task to be performed, about and instructions)
- Menu
    Access menu options
        As a user, I want to access a menu with options for configuring my habits, viewing reports, editing my profile, and signing out, so that I can easily navigate to different parts of the app.
    Navigate to profile  (settings)
        As a user, I want to access a menu with options to configure my habits, view reports, edit my profile, and sign out, so that I can easily navigate different parts of the app.
    Navigate to habits page
        As a user, I want to access the habits page from the menu, so that I can configure and manage my habits. Add/delete/move habits. Personalize the habits.
    Sign out from menu
        As a user, I want to sign out of my account using an option in the menu, so that I can securely log out when I'm finished using the app.
- Profile\Settings page (design: primary color bg with rounded form fields)
    View personal information
        As a user, I want to view my saved name, username, age, and country on my profile page, so that I can see the details I provided during registration.
    Edit personal information
        As a user, I want to update my name, username, age, and country on my profile page, so that I can keep my information up to date.
    Save updated information
        As a user, I want the changes I make to my profile to be saved, so that my updated details are stored and reflected throughout the app.
    Update name in header
        As a user, I want my updated name to be displayed in the app's header after I change it in the profile, so that my changes are immediately visible.
    Dark\Light Theme Mode
        As a user, I want to change between light and dark theme modes in the settings page.
- Reports page
    View weekly reports
        As a user, I want to see a report of my weekly habit progress so that I can understand how well I am maintaining my habits.
    Visualize completed habits
        As a user, I want to see a chart of my completed habits for each day of the week so that I can quickly identify trends in my progress.
    View all habits
        As a user, I want to see both completed and incomplete habits in my report so that I have a comprehensive view of my habit tracking performance.
- Notification/reminder
    Enable/disable notifications
        As a user, I want to be able to enable or disable notifications for the app, so that I can choose whether or not to receive reminders for my habits.
    Add habits for notifications
        As a user, I want to select specific habits to receive notifications for, so that I only get reminders for the habits I am actively working on.
    Set notification times
        As a user, I want to have the option to receive notifications three times a day (morning, afternoon, evening) for all selected habits, so that I get timely reminders throughout the day to complete my habits.
    Daily 0900 reminder
        As a user, I want to receive a daily reminder notification so that I don’t forget to complete my tasks.
- Introductory Carousel How-To Guide
    First time app load shows a carousel on how to use the app. Saves completion of guide in local storage and checks on subsequent bootstraps.
