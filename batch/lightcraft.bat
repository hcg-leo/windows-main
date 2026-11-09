@echo off
cd /d "%USERPROFILE%\Desktop"
git clone https://github.com/storytold/lightcraft
cd lightcraft
cargo run --release -p lightcraft
