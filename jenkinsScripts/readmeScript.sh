#!/bin/bash

# In readme always one space between start and end comments
# Line to search
line=`grep -n '^<!---Start place for the badge -->' README.md  | cut -d":" -f1`
# Next line where we place the badge
(( line++ ))

if [[ $1 == 0 ]]; then
    awk 'NR=='"${line}"'{$0="RESULTADO DE LOS ÚLTIMOS TESTS: [![Cypress.io](https://img.shields.io/badge/tested%20with-Cypress-04C38E.svg)](https://www.cypress.io/)"} 1' README.md > README.tmp && mv README.tmp README.md
else
    awk 'NR=='"${line}"'{$0="RESULTADO DE LOS ÚLTIMOS TESTS: [![Cypress.io](https://img.shields.io/badge/test-failure-red)](https://www.cypress.io/)"} 1' README.md > README.tmp && mv README.tmp README.md
fi


