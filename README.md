# lambda-with-container-images
A CloudFormation template to create an AWS lambda function with container image based runtime

I'm gonna create a docker image with a bash script as CMD. The bash script will list all the reserved insatnce in the account across all regions. The same script can be found in the following repo.
https://github.com/alvinjaison/list-aws-reserved-instances

**Prerequisites**

1. Create an AWS ECR repository from the console
2. Clone this repo and enter into the cloned repo directory
   ```
   cd lambda-with-container-images
   ```
3. Get
   ```
   AccountID=$(aws sts get-caller-identity --query Account --output text)
   region='us-east-1'
   aws ecr get-login-password --region $region | docker login --username AWS --password-stdin $AccountID.dkr.ecr.$region.amazonaws.com
   ```
5. Build the docker image and push it into ECR repository. 
   ```
   docker build -t lambda-container .
   docker tag lambda-container:latest $AccountID.dkr.ecr.$region.amazonaws.com/lambda-container:latest
   docker push $AccountID.dkr.ecr.$region.amazonaws.com/lambda-container:latest
   ```
4. Create the cloudformation stack from AWS console or using aws-cli
   ```
   aws cloudformation create-stack --stack-name riFinder --template-body file://riFinderTemplate.yaml
   ```
   
