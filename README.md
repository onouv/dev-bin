# A Set Of Useful little Bash Tools For Development in Linux

| cmd | purpose |
| --- | --- |
| **`dck-init`** |   handle dockerhub login and setting of the environment for quarkus   |
| **`app2dck`** |  build and deploy quarkus to dockerhub/rabaul  |
| **`app2k8s`** | deploy to kubernetes cluster |
| **`app-prep-debug`** | prepare ports in k8s for debug |
| **`mnk`** |   start, stop minikube with virtualbox or call otherwise |
| wsup | start up a tmux workspace with github/docker/k8s env |
| wsdown | kill a tmux workspace |
| gitclip | take git ssh password into CTRL-SHIFT-V clipboard (in wsup workspace) |
| dockerclip | take docker password into CTRL-SHIFT-V clipboard (in wsup workspace) |
| ws | a CLI frontend to wsup, wsdown gitclip and dockerclip |
| unclip | erase CTRL-SHIFT-V clipboard |
