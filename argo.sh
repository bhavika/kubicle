# Use args.yaml to do a test of argument passing 

argo submit args.yaml 
argo list 
argo get arguments-parameters-xxx
argo logs -w arguments-parameters-xxx
argo delete arguments-parameters-xxx 

