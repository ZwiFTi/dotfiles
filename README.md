# dotfiles

Install

    cd ~                                                                          
    git clone https://github.com/ZwiFTi/dotfiles.git
    cd dotfiles                                            
    chmod +x install.sh
    ./install.sh
   
List tracked files

    git ls-tree -r master --name-only 

First Time Git Configuration

    # sets up Git with your name
    git config --global user.name <my_full_name>

    # sets up Git with your email
    git config --global user.email <your_email_address>

    # makes sure that Git output is colored
    git config --global color.ui auto

    # displays the original state in a conflict
    git config --global merge.conflictstyle diff3

    git config --list


