if [ $1 -eq 0 ] && [ $2 -eq 0 ] && [ $3 -eq 0 ] && [ $4 -eq 0 ]; then
    vercel . --token $5 --confirm --name santi_jenkins
    exit 0
else
    exit 1
fi