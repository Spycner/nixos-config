{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      astro-build.astro-vscode
      njpwerner.autodocstring
      aaron-bond.better-comments
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      adpyke.codesnap
      ms-azuretools.vscode-docker
      dotenv.dotenv-vscode
      usernamehw.errorlens
      dbaeumer.vscode-eslint
      # pomdtr.excalidraw-editor
      eamodio.gitlens
      ecmel.vscode-html-css
      oderwat.indent-rainbow
      visualstudioexptteam.vscodeintellicode
      visualstudioexptteam.intellicode-api-usage-examples
      # aykutsarac.jsoncrack-vscode
      ms-toolsai.jupyter
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.jupyter-keymap
      ms-toolsai.jupyter-renderers
      ms-toolsai.vscode-jupyter-slideshow
      # vintharas.learn-vim
      yzhang.markdown-all-in-one
      davidanson.vscode-markdownlint
      jnoortheen.nix-ide
      ibm.output-colorizer
      christian-kohler.path-intellisense
      # kevinrose.vsc-python-indent
      esbenp.prettier-vscode
      ms-python.vscode-pylance
      ms-python.python
      ms-python.debugpy
      # njqdev.vscode-python-typehint
      mechatroner.rainbow-csv
      charliermarsh.ruff
      # albert.tabout
      bradlc.vscode-tailwindcss
      # ms-vscode.vscode-typescript-tslint-plugin
      asvetliakov.vscode-neovim
    ];
  };
}
