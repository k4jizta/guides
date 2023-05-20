create pool by shell command
`pvesh create /pools --poolid [poolid] --comment mycomment`

create more then 1 poll by script 
```
#!/bin/bash
# Basic while loop
counter=1
while [ $counter -le 15 ]
do
pvesh create /pools --poolid pool$counter --comment 'create via sh script'
echo $counter
((counter++))
done
```
