# insta_notification
AWS Lambda with Ruby

Since [Amazon announced](https://aws.amazon.com/blogs/compute/announcing-ruby-support-for-aws-lambda/) that AWS Lambda now supports Ruby, so why don't I take a shot? Here I tried.

#### Upload
```
sam package --template-file template.yml --s3-bucket bucket_name --output-template-file packaged.yaml
```
#### Deploy
```
sam deploy --template-file ./packaged.yaml --stack-name stack_name --capabilities CAPABILITY_IAM --region us-east-1
```
