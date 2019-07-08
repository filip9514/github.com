# info on https://askubuntu.com/questions/527166/how-to-set-subl-protocol-handler-with-unity

echo -e '[Desktop Entry]
Name=google-chrome
GenericName=Browser
Comment=Handle URL Scheme google-chrome://
Exec=/usr/share/handlers/google-chrome %u
Terminal=false
Type=Application
MimeType=x-scheme-handler/google-chrome;
Icon=google-chrome
Categories=google-chrome
Name[en_US]=google-chrome'  | sudo tee /usr/share/applications/google-chrome-handler.desktop

echo -e  '[Desktop Entry]
Name=Sublime Text 3 URL Handler
GenericName=Text Editor
Comment=Handle URL Scheme subl://
Exec=/usr/share/handlers/sublime-handler %u
Terminal=false
Type=Application
MimeType=x-scheme-handler/subl;
Icon=sublime-text-3
Categories=TextEditor;Development;Utility;
Name[en_US]=Sublime Text 3 URL Handler'  | sudo tee /usr/share/applications/sublime-handler.desktop

echo -e '[Desktop Entry]
Name=terminal
GenericName=terminal
Comment=Handle URL Scheme terminal://
Exec=/usr/share/handlers/terminal %u
Terminal=false
Type=Application
MimeType=x-scheme-handler/terminal;
Icon=terminal
Categories=terminal
Name[en_US]=terminal' | sudo tee /usr/share/applications/terminal-handler.desktop

sudo update-desktop-database


echo -e '#!/usr/bin/env bash
request="${1#*://}"             # Remove schema from url (subl://)
request="${request#*?url=}"     # Remove open?url=
request="${request//%2F//}"     # Replace %2F with /
request="${request/&line=/:}"   # Replace &line= with :
request="${request/&column=/:}" # Replace &column= with :

subl -a "$request"                 # Launch sublime' | sudo tee /usr/share/handlers/sublime-handler

echo -e '#!/usr/bin/env bash
request="${1#*://}"
gnome-terminal --working-directory=$HOME/$request -- bash -c "git status & bash"
' | sudo tee /usr/share/handlers/terminal

echo -e '#!/usr/bin/env bash
request="${1#*://}"
google-chrome "https://$request"' | sudo tee /usr/share/handlers/google-chrome



sudo chmod +x /usr/share/handlers/sublime-handler
sudo chmod +x /usr/share/handlers/terminal
sudo chmod +x /usr/share/handlers/google-chrome


xdg-mime default /usr/share/applications/sublime-handler.desktop x-scheme-handler/subl
xdg-mime default /usr/share/applications/google-chrome-handler.desktop x-scheme-handler/google-chrome
xdg-mime default /usr/share/applications/terminal-handler.desktop x-scheme-handler/terminal




echo -e '[Desktop Entry]
Name=git-log
Type=Application
Exec=/usr/share/handlers/git-log %u
MimeType=x-scheme-handler/git-log;
' | sudo tee /usr/share/applications/git-log-handler.desktop

sudo update-desktop-database

echo -e '#!/usr/bin/env bash
request="${1#*://}"
bash -c "cd $HOME/$request ; git log --oneline --all --decorate --graph  2>&1 | tee $HOME/github.com/report.txt > /dev/null"
' | sudo tee /usr/share/handlers/git-log

sudo chmod +x /usr/share/handlers/git-log
xdg-mime default /usr/share/applications/git-log-handler.desktop x-scheme-handler/git-log



echo -e '[Desktop Entry]
Name=git-status
Type=Application
Exec=/usr/share/handlers/git-status %u
MimeType=x-scheme-handler/git-status;
' | sudo tee /usr/share/applications/git-status-handler.desktop

sudo update-desktop-database

echo -e '#!/usr/bin/env bash
request="${1#*://}"
bash -c "cd $HOME/$request ; git status  2>&1 | tee $HOME/github.com/report.txt > /dev/null"
' | sudo tee /usr/share/handlers/git-status

sudo chmod +x /usr/share/handlers/git-status
xdg-mime default /usr/share/applications/git-status-handler.desktop x-scheme-handler/git-status

