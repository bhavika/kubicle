## Notes

- Running Batch jobs on an AWS EKS cluster manually 
    
  Following this tutorial https://kubernetes.io/docs/tasks/job/fine-parallel-processing-work-queue/
  
  Steps:
  
  1. Build the Docker image inside `queue`.
    
     `docker build -t job-wq-2 .`  

  2. Tag the Docker image. 
  
     `docker tag job-wq-2:latest aws-account-no.dkr.ecr.us-east-1.amazonaws.com/job-wq-2:latest`
     
  3. Log in to AWS ECR.
  
     `$(aws ecr get-login --no-include-email --region us-east-1)`
  
  4. Push the Docker image. 
  
     `docker push aws-account-no.dkr.ecr.us-east-1.amazonaws.com/job-wq-2:latest`
     
  5. Start the Redis master service. 
  
        `kubectl apply -f redis-pod.yaml`
        
  6. Start the Redis service on EKS. 
  
     `kubectl apply -f redis-service.yaml`
     
  7. Fill the Redis queue with some tasks. Start a temporary interactive pod to interact 
     with the Redis CLI. 
  
     `kubectl run -i --tty temp --image redis --command "/bin/sh"`

     Hit enter.
      
  8. Start the Redis CLI and create a list with some items in it. 
       
        `redis-cli -h redis`
     
        `redis:6379> rpush job2 "apple"`
        
     Replace `apple` with other items to keep adding more work to the queue. 
     
  9. Apply the job template.
  
        `kubectl apply -f queue/job.yaml`
        
  10. Check the status of the jobs using -  
  
        `kubectl describe jobs/job-wq-2` 
 
  11. For each running pod, you can see the logs using -
        
        `kubectl get pods`
  
        `kubectl logs pods/job-wq-2-xxxx`
        
        
- Argo for Batch workloads

Parameters:  https://github.com/argoproj/argo/blob/master/examples/README.md#parameters

YAML example: https://github.com/argoproj/argo/blob/master/examples/arguments-parameters.yaml


- Using Docker 

We use the [whalesay image](https://hub.docker.com/r/docker/whalesay/)