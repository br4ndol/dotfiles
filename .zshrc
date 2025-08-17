if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias zshconfig="nano ~/.zshrc"
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias update-repos="sudo reflector --verbose --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist; y -Syy"
alias y="yay"
alias c="sudo pacman -Sc --noconfirm; sudo pacman -Rns $(pacman -Qtdq); yay -Scc --noconfirm; flatpak uninstall --unused; sudo systemctl start systemd-tmpfiles-clean.service"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
