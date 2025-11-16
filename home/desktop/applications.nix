{ config, pkgs, ... }:

{
  xdg.desktopEntries = {
    claude = {
      name = "Claude";
      exec = "google-chrome-stable --app=https://claude.ai";
      icon = "claude";
      categories = [ "Network" "WebBrowser" "Development" ];
      comment = "Claude AI Assistant";
    };
    youtube = {
      name = "YouTube";
      exec = "google-chrome-stable --app=https://youtube.com";
      icon = "youtube";
      categories = [ "Network" "WebBrowser" "AudioVideo" ];
      comment = "YouTube Web App";
    };
    oreilly = {
      name = "O'Reilly";
      exec = "google-chrome-stable --app=https://learning.oreilly.com/home/";
      icon = "oreilly";
      categories = [ "Network" "WebBrowser" "AudioVideo" ];
      comment = "O'Reilly Web App";
    };
    reddit = {
      name = "Reddit";
      exec = "google-chrome-stable --app=https://reddit.com";
      icon = "reddit";
      categories = [ "Network" "WebBrowser" ];
      comment = "Reddit Web App";
    };
    gmail = {
      name = "Gmail";
      exec = "google-chrome-stable --app=https://mail.google.com";
      icon = "gmail";
      categories = [ "Network" "Email" ];
      comment = "Gmail Web App";
    };
  };
}
