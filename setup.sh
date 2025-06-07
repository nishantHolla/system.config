#!/bin/sh

# Fonts

mkdir -p $HOME/.local/share

if [ -e $HOME/Fonts ]; then
  echo "$HOME/Fonts already exists. Skipping...";
else
  echo "Pulling down fonts..."
  git clone git@github.com:nishantHolla/fonts.git $HOME/Fonts
fi

if [ -e $HOME/.local/share/fonts ]; then
  echo "$HOME/.local/share/fonts already exists. Skipping linking...";
else
  echo "Linking fonts..."
  ln -s $HOME/Fonts $HOME/.local/share/fonts
fi

# Icons

mkdir -p $HOME/.local/share/icons

if [ -e $HOME/Icons ]; then
  echo "$HOME/Icons already exists. Skipping...";
else
  echo "Pulling down icons..."
  git clone git@github.com:nishantHolla/icons.git $HOME/Icons
fi

if [ -e $HOME/.local/share/icons/GI ]; then
  echo "$HOME/.local/share/icons/GI already exists. Skipping linking...";
else
  echo "Linking icons..."
  ln -s $HOME/Icons/GI $HOME/.local/share/icons/GI
fi
