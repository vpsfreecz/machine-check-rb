{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell rec {
  name = "machine-check";

  buildInputs = with pkgs; [
    bundix
    git
    ruby
  ];

  shellHook = ''
    export GEM_HOME="$(pwd)/.gems"
    export PATH="$(ruby -e 'puts Gem.bindir'):$PATH"
    export RUBYLIB="$GEM_HOME"
    gem install --no-document bundler geminabox
    $GEM_HOME/bin/bundle install
  '';
}
