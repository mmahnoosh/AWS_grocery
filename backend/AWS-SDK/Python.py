import boto3

def lambda_handler(event, context):
    # Initialize AWS clients
    ec2_client = boto3.client('ec2')
    sns_client = boto3.client('sns')

    # Get all EC2 instances in the region
    response = ec2_client.describe_instances()
    instances = []
    for reservation in response['Reservations']:
        instances.extend(reservation['Instances'])

     # Check each EC2 instance and publish alarm to SNS if needed
    for instance in instances:
        instance_id = instance['InstanceId']
        instance_status_check = None
        system_status_check = None

        # Check status checks from EC2 API (for example, for status check failures)
        status_check_response = ec2_client.describe_instance_status(
            InstanceIds=[instance_id]
        )
        if 'InstanceStatuses' in status_check_response and len(status_check_response['InstanceStatuses']) > 0:
            instance_status_check = status_check_response['InstanceStatuses'][0]['InstanceStatus']['Details'][0]['Status']
            system_status_check = status_check_response['InstanceStatuses'][0]['SystemStatus']['Details'][0]['Status']

        # Check health criteria and publish to SNS if needed
        if (instance_status_check == 'failed' or system_status_check == 'failed'):
            sns_client.publish(
                TopicArn='arn:aws:sns:us-east-1:448049801543:Mahnoosh-SNS',
                Subject=f"EC2 Instance Health Alarm: {instance_id}",
                Message=f"The EC2 instance {instance_id} in <your_region> has a health issue. Instance Status Check: {instance_status_check}, System Status Check: {system_status_check}."
            )
                # you can customize you message