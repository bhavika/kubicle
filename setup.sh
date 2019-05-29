pip3 install awscli --upgrade --user

# eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

sudo mv /tmp/eksctl /usr/local/bin

eksctl version

# create a cluster
eksctl create cluster \
--name bhavika-kubicle \
--version 1.12 \
--nodegroup-name standard-workers \
--node-type t3.medium \
--nodes 3 \
--nodes-min 1 \
--nodes-max 4 \
--node-ami auto


# Install aws-iam-authenticator 
curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.12.7/2019-03-27/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator
mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.zshrc

aws-iam-authenticator help

# Install Kubectl 

curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.14.0/bin/linux/amd64/kubectl
chmod +x ./kubectl

# Move kubectl to path
sudo mv ./kubectl /usr/local/bin/kubectl

# check version
kubectl version 

# test kubectl configuration is correct
kubectl get svc
