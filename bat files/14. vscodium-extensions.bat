@echo off
echo installing VS codium extensions...

call codium --install-extension arcticicestudio.nord-visual-studio-code
call codium --install-extension vscodevim.vim
call codium --install-extension esbenp.prettier-vscode
call codium --install-extension nur-srijan.markdown-rich-preview

echo done
pause