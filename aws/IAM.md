# IAM Resources with AWS Cli

## List User

- ```aws iam list-users```

## Create New Group

- ```aws iam create-group --group-name```

## Attach User to Group

- ```aws iam add-user-to-group --user-name <username> --group-name <group-name>```

## Attach Policy to Group

- ```aws iam attach-group-policy --group-name <group-name> --policy-arn <policy-arn>```

## Attach User to Policy

- ```aws iam attach-user-policy --user-name <user-name> --policy-arn <policy-arn>```

## Other Commands

- ```aws  iam list-attached-group-policies --group-name <group-name>```
- ```aws  iam list-attached-user-policies --user-name <user-name>```
