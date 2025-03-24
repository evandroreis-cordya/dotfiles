#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

declare -r HOSTNAME="$1"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   UI & UX\n\n"


execute "defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true && \
         defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true" \
   "Evite criar arquivos '.DS_Store' em volumes de rede ou USB"

# execute "defaults write com.apple.menuextra.battery ShowPercent -string 'NO'" \
#     "Ocultar porcentagem da bateria da barra de menus"

execute "sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true" \
    "Mostrar menu de idioma no canto superior direito da tela de inicialização"

execute "defaults write com.apple.CrashReporter UseUNC 1" \
    "Os relatórios de falhas aparecem como notificações"

# execute "defaults write com.apple.LaunchServices LSQuarantine -bool false" \
#     "Desativa o painel 'Are you sure you want to open this application?'"

execute "defaults write com.apple.print.PrintingPrefs 'Quit When Finished' -bool true" \
    "Fecher automaticamente o aplicativo da impressora assim que os trabalhos de impressão estiverem concluídos."

execute "defaults write com.apple.screencapture disable-shadow -bool true" \
    "Desativar sombra nas capturas de tela"

execute "defaults write com.apple.screencapture location -string '$HOME/Desktop'" \
    "Guarde screenshots na área de trabalho"

execute "defaults write com.apple.screencapture type -string 'png'" \
    "Guarde screenshots como PNGs"

execute "defaults write com.apple.screensaver askForPassword -int 1 && \
         defaults write com.apple.screensaver askForPasswordDelay -int 0"\
    "Exigir senha imediatamente após o modo de suspensão ou modo de proteção de tela"

execute "defaults write -g AppleFontSmoothing -int 2" \
    "Ativar a renderização de fontes subpixel em LCDs que não sejam da Apple"

execute "defaults write -g AppleShowScrollBars -string 'Always'" \
    "Mostra sempre barras de rolagem"

execute "defaults write -g NSDisableAutomaticTermination -bool true" \
    "Desativar o término automático de aplicativos inativos"

execute "defaults write -g NSNavPanelExpandedStateForSaveMode -bool true" \
    "Expanda o painel salvar por padrão"

execute "defaults write -g NSTableViewDefaultSizeMode -int 2" \
    "Definir o tamanho do ícone da barra lateral como médio"

execute "defaults write -g NSUseAnimatedFocusRing -bool false" \
    "Desative a animação do anel de foco superior"

execute "defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false" \
    "Desative resume system-wide"

execute "defaults write -g PMPrintingExpandedStateForPrint -bool true" \
    "Expanda o painel de impressão por padrão"

execute "sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string '$HOSTNAME' && \
         sudo scutil --set ComputerName '$HOSTNAME' && \
         sudo scutil --set HostName '$HOSTNAME' && \
         sudo scutil --set LocalHostName '$HOSTNAME'" \
    "Definir o nome do computador"

execute "sudo systemsetup -setrestartfreeze on" \
    "Reinicie automaticamente se o computador estiver congelado"

execute "sudo defaults write /Library/Preferences/com.apple.Bluetooth.plist ControllerPowerState 0 && \
         sudo launchctl unload /System/Library/LaunchDaemons/com.apple.blued.plist && \
         sudo launchctl load /System/Library/LaunchDaemons/com.apple.blued.plist" \
    "Deslige Bluetooth"

execute "for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
            sudo defaults write \"\${domain}\" dontAutoLoad -array \
                '/System/Library/CoreServices/Menu Extras/TimeMachine.menu' \
                '/System/Library/CoreServices/Menu Extras/Volume.menu'
         done \
            && sudo defaults write com.apple.systemuiserver menuExtras -array \
                '/System/Library/CoreServices/Menu Extras/Bluetooth.menu' \
                '/System/Library/CoreServices/Menu Extras/AirPort.menu' \
                '/System/Library/CoreServices/Menu Extras/Battery.menu' \
                '/System/Library/CoreServices/Menu Extras/Clock.menu'
        " \
    "Ocultar ícones de Time Machine e Volume da barra de menu"

killall "SystemUIServer" &> /dev/null
