#!/bin/bash
# Created by: Kyle Simmons
# Github: https://github.com/kyle-c-simmons

# Array of random errors 
randomError=('Maybe you need some help?' 'There is no hidden menus here...' 
'Command not found' 'What are you trying to do?' 'Did you read anything?'
'Enter a valid command' 'How hard is it to enter the correct number?'
'Tip: Have tried reading the menu?')

function interface() {
    echo " _______                          _______                                          
    |   |   |.-----..-----..----.    |   |   |.---.-..-----..---.-..-----..-----..----.
    |   |   ||__ --||  -__||   _|    |       ||  _  ||     ||  _  ||  _  ||  -__||   _|
    |_______||_____||_____||__|      |__|_|__||___._||__|__||___._||___  ||_____||__|  
                                                                   |_____|"

    echo -e "\nUser and Accont management system. Create, delete, manage groups 
and users in a easy way."

    echo -e "\n\e[34mCreated by: Kyle Simmons\nGithub: https://github.com/kyle-c-simmons\n"
}

function displayMainMenu() {

interface
    echo -e "\e[33mSelect from the menu:"

    echo -e "\e[34m
    USERS \e[39m
        1. Add user
        2. Update user
        3. Delete user
    \e[34m
    GROUPS \e[39m
        4. Add group
        5. Update group
        6. Delete group
    \e[34m
    DISPLAY \e[39m
        7. Users
        8. Groups
        9. Help and Credits
    \e[34m
    10. Exit Account Manager
    \e[31m

    Enter your choice >\e[39m \c\n"
}

function userUpdateMenu() {
    interface
    echo -e "\e[33mSelect from the menu:"

    echo -e "\e[34m
    UPDATE USER \e[39m
        1. Update password
        2. Add user to a group
        3. Update Password expiry
        4. New home directory
        5. Add a user comment
    \e[34m
    10. Reutn to main menu
    \e[31m

    
    Enter your choice >\e[39m \c\n"
}

function groupUpdateMenu() {
    interface
    echo -e "\e[33mSelect from the menu:"

    echo -e "\e[34m
    UPDATE GROUP \e[39m
        1. Update group name
    \e[34m
    10. Reutn to main menu
    \e[31m

    
    Enter your choice >\e[39m \c\n"

}

function usersMenu() {
    interface
    echo -e "\e[33mSelect from the menu:"

    echo -e "\e[34m
    DISPLAY \e[39m
        1. Search for a specific user
        2. Display all users
    \e[34m
    10. Reutn to main menu
    \e[31m

    
    Enter your choice >\e[39m \c\n"
}

function groupsMenu() {
    interface
    echo -e "\e[33mSelect from the menu:"

    echo -e "\e[34m
    DISPLAY \e[39m
        1. Search for a specific group
        2. Display all groups
    \e[34m
    10. Reutn to main menu
    \e[31m

    
    Enter your choice >\e[39m \c\n"
}

function menuHelp() {
    interface
    echo -e "
\e[39m
NAME:
    Usermanager

DESCRIPTION:
    Usermanager - User and account management system. Create, delete,
    manage groups and users in a easy way.

COMMANDS:  
    USERS - ADD USER: Adds a new user with a shell and home directory.
    USERS - UPDATE USER: Update a users password, group, password expiry,
    new home directory and add a comment.
    USERS - DELETE USER: Removes a user from the system.
    
    GROUPS - ADD GROUP: Adds a new group.
    GROUPS - UPDATE GROUP: Update a groups name.
    GROUPS - DELETE GROUP: Delete a group from the system.
    
    DISPLAY - USERS: Displays a specific user or all users.
    DISPLAY - GROUPS: Displays a specific group or al groups."
}

function errorMessage() {
    errorLine="====================================================="
    printError="ERROR MESSAGE: ${randomError[RANDOM%5]}     " 
    echo -e "\n\n\e[31m ${errorLine} \n\e[39m ${printError} \n\e[31m ${errorLine} \e[39m"
    sleep 2
    clear
    displayMainMenu
    mainMenu 
}

# Calls all functions for displaying the main menu
function mainMenu() {
    read menuInput

    case $menuInput in
        "1" )
            addUser ;;
        "2" )
            clear
            userUpdateMenu
            updateUser ;;
        "3" )
            userDel ;;
        "4" )
            addGroup ;;
        "5" )
            clear
            groupUpdateMenu
            modGroup ;;
        "6" )
            groupDel ;;
        "7" )
            clear
            usersMenu
            displayUsers ;;
        "8" )
            clear
            groupsMenu
            displayGroups ;;
        "9" )
            clear
            menuHelp
            returnToMenu ;;
        "10" )
            exit ;;
        * )
            errorMessage ;;
    esac           
}

# Allows user to create new user with password
function addUser() {
    clear
    interface
    echo -e "Creating a user...\n"
    echo -e "\e[31mChoose a username >\e[39m \c\n"
    read usernameInput
    useradd -s /bin/bash -d /home/$usernameInput -m $usernameInput
    passwd $usernameInput
    echo -e "\n\e[31mUser created:\e[39m $(cat /etc/passwd | grep $usernameInput)"
    returnToMenu
}

# Update a users values
function updateUser() {
    read usersInput

    case $usersInput in

        # Update the selected users password
        "1" )
            clear
            interface
            echo -e "\e[31mUpdating password...\e[39m\n"
            echo -e "\e[31mChoose a username to update >\e[39m \c\n"
            read selectedUser
            passwd $selectedUser
            returnToMenu ;;
     
        # Update the users group
        "2" )
            clear
            interface
            echo -e "\e[31mUpdating users group...\e[39m\n"
            echo -e "\e[31mChoose a user to add to a group >\e[39m \c\n"
            read selectedUser
            echo -e "$(cat /etc/passwd | grep $selectedUser)"
            echo -e "\e[31mChoose a group for the user >\e[39m \c\n"
            read selectedGroup
            usermod -g $selectedGroup $selectedUser
            echo -e "$(cat /etc/passwd | grep $selectedUser)"
            returnToMenu ;;
        
        # Set a password expiry date 
        "3" )
            clear
            interface
            echo -e "\e[31mUpdating users expiry date...\e[39m\n"
            echo -e "\e[31mChoose a user  >\e[39m \c\n"
            read selectedUser
            echo -e "$(chage -l $selectedUser)"
            echo -e "\e[31mSet a password expriy in format (YYYY-MM-DD) >\e[39m \c\n"
            read passwordExpires
            echo -e "$(chage -l $selectedUser)"
            returnToMenu ;;

        # Create a home directory for the user 
        "4" )
            clear
            interface
            echo -e "\e[31mCreating new users home directory...\e[39m\n"
            echo -e "\e[31mChoose a user  >\e[39m \c\n"
            read selectedUser
            echo -e "\e[31mChoose a home directory name >\e[39m \c\n"
            read homeDirectory
            usemod -d /home/$homeDirectory $selectedUser 
            returnToMenu ;; 
        
        # Add a comment to the user
        "5" )
            clear
            interface
            echo -e "\e[31mUpdating users comment...\e[39m\n"
            echo -e "\e[31mChoose a user  >\e[39m \c\n"
            read selectedUser
            echo -e "$(cat /etc/passwd | grep $selectedUser)"
            echo -e "\e[31mInput a comment for the user >\e[39m \c\n"
            read userComment
            echo -e "$(cat /etc/passwd | grep $userComment)"
            returnToMenu ;; 
        
        # Returns user to main menu
        "10" )
            clear 
            displayMainMenu
            mainMenu ;;

        ## Returns error 
        * )
            errorMessage ;;  
    esac
}

# Delete a user
function userDel() {
    clear
    interface
    echo -e "Deleting a user...\n"
    echo -e "\e[31mChoose a username to delete >\e[39m \c\n"
    read deleteuserInput
    userdel -r $deleteuserInput
    echo -e "\n\e[31mUser Deleted:\e[39m $deleteuserInput"
    returnToMenu
}

# Add a group
function addGroup() {
    clear
    interface
    echo -e "Adding a group...\n"
    echo -e "\e[31mChoose a group name >\e[39m \c\n"
    read groupInput
    groupadd $groupInput
    echo -e "\n\e[31mGroup created:\e[39m $(cat /etc/group | grep $groupInput)"
    returnToMenu
}

# Modify a group
function modGroup() {

    read groupsInput
    case $groupsInput in

        # Displays the group searched
        "1" )
            clear
            interface
            echo -e "\e[31mEnter group name >\e[39m \c\n"
            read selectedGroup
            echo -e "\n\e[34mGroup: \e[39m$(cat /etc/group | grep $selectedGroup)"
            echo -e "\e[31mEnter new group name >\e[39m \c\n"
            read newGroup
            groupmod -n $newGroup $selectedGroup
            echo -e "\n\e[34mGroup: \e[39m$(cat /etc/group | grep $selectedGroup)"
            returnToMenu ;; 
       
        # Returns user to main menu
        "10" )
            clear 
            displayMainMenu
            mainMenu ;;

        ## Returns error 
        * )
            errorMessage ;;  
    esac
}


# Delete a group
function groupDel() {
    clear
    interface
    echo -e "Deleting a group...\n"
    echo -e "\e[31mChoose a group name to delete >\e[39m \c\n"
    read deletegroupInput
    groupdel $deletegroupInput
    echo -e "\n\e[31mGroup Deleted:\e[39m $deletegroupInput"
    returnToMenu
}

# Display users MENU function
function displayUsers() {
    read usersInput

    case $usersInput in

        # Displays the user searched
        "1" )
            clear
            interface
            echo -e "\e[31mEnter user to search >\e[39m \c\n"
            read selectedUser
            echo -e "\n\e[34mUser: \e[39m$(cat /etc/passwd | grep $selectedUser)" 
            echo -e "\e[34mEncrypted password: \e[39m$(cat /etc/shadow | grep $selectedUser)\n"
            returnToMenu ;;
     
        # Displays all users
        "2" )
            clear
            interface
            echo -e "\n\e[34mAll users: \n\e[39m$(cat /etc/passwd)" 
            returnToMenu ;;
        
        # Returns user to main menu
        "10" )
            clear 
            displayMainMenu
            mainMenu ;;

        ## Returns error 
        * )
            errorMessage ;;  
    esac
}


function displayGroups() {
    read groupsInput

    case $groupsInput in

        # Displays the group searched
        "1" )
            clear
            interface
            echo -e "\e[31mEnter group to search >\e[39m \c\n"
            read selectedGroup
            echo -e "\n\e[34mGroup: \e[39m$(cat /etc/group | grep $selectedGroup)" 
            returnToMenu ;; 
       
        # Displays all groups
        "2" )
            clear
            interface
            echo -e "\n\e[34mAll groups: \n\e[39m$(cat /etc/group)" 
            returnToMenu ;;
        
        # Returns user to main menu
        "10" )
            clear 
            displayMainMenu
            mainMenu ;;

        ## Returns error 
        * )
            errorMessage ;;  
    esac
}

# After a command is entered, call this function
function returnToMenu() { 
    echo -e "\n\e[34mDo you want to return to the main menu? ('yes' or 'y')"
    echo -e "or press ENTER to exit\n"
    echo -e "\e[31mEnter your choice >\e[39m \c\n"
    read input
    if [[ $input == "yes" || $input == "y" ]]
    then
        mainHandler
    else 
        exit
    fi
}

# Displays the main starting menu
function mainHandler() {
    clear
    displayMainMenu
    mainMenu
}

# Initial function to call
if [[ $UID != 0 ]]; 
then
    echo -e "PermissionError: Permission denied.\nTo execute, use sudo or root."
    exit 1
fi

mainHandler
