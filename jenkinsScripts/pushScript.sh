#!/bin/bash
git checkout master
git config --global user.email "santiagosolellin@gmail.com"
git config --global user.name "SantiSL5"
git add README.md
git commit -m "Pipeline ejecutada por $1. Motivo: $2"
git remote set-url origin $3
git push origin HEAD:master