{ config, pkgs, ... }:

{
  home.username      = "arthur";
  home.homeDirectory = "/home/arthur";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    neovim
    lua
    nodejs
    yarn
    python3
    python3Packages.pip
    python3Packages.black
    python3Packages.ruff
    python3Packages.debugpy
    pyright
    rustc
    cargo
    clippy
    rustfmt
    lldb
    rust-analyzer

    # Ferramentas pessoais
    zsh
    zsh-powerlevel10k
  ];

  programs.zsh = {
  enable = true;

  # Habilita “compinit” e também adiciona pacote nix-zsh-completions
  enableCompletion = true;

  # Habilita o plugin zsh-autosuggestions
  autosuggestion = {
  enable = true;
  highlight = "fg=8";
  strategy = [ "history" ];
  };

  # Habilita o plugin zsh-syntax-highlighting
  syntaxHighlighting = {
    enable = true;
  };

  # Oh My Zsh (opcional; o tema e plugins serão gerenciados pelo Home Manager)
  "oh-my-zsh" = {
    enable  = true;
    plugins = [ "git" "sudo" ];
    #theme   = "powerlevel10k/powerlevel10k";
  };

  # Conteúdo adicional no início do .zshrc (para carregar o tema powerlevel10k)
  initContent = ''
    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    if [ -f ~/.zshrc.d ]; then
      source ~/.zshrc.d
    fi
    if [ -f ~/.p10k.zsh ]; then
      source ~/.p10k.zsh
    fi
  '';
};
  programs.git.enable = true;
  home.file = {
    ".xprofile".source =                ./dotfiles/xprofile;
    ".xsession".source =                ./dotfiles/xsession;
    ".spectrwm.conf".source =           ./dotfiles/spectrwm.conf;
    #".gitconfig".source =               ./dotfiles/gitconfig;
    ".p10k.zsh".source =                ./dotfiles/p10k.zsh;
    ".config/kitty/kitty.conf".source = ./dotfiles/kitty.conf;
    ".zshrc.d".source        =          ./dotfiles/zshrc.d;
    #adicione outros dotfiles aqui
  };
}

