# AWS_Capstone
I wanted to explore a simple way to secure communication between applications running on AWS.

The problem is straightforward: when one application calls another service, how do we verify who sent the request, and whether that application has permission to access the service?

One approach is to use mutual TLS, or mTLS, together with an authorization service. That approach can work well, but it also introduces responsibilities such as issuing and rotating certificates, managing trust, and maintaining the authorization service.

My idea was to use Amazon VPC Lattice with IAM authentication to reduce that operational work, particularly for small and medium-sized businesses already running their applications on AWS.

To demonstrate the idea, I built a small lab. I used an EC2 instance as the application sending requests and a Lambda function as the service receiving them. VPC Lattice sits between them and controls access.

I started by creating an IAM role for the application on EC2. This gives the application an AWS identity and temporary credentials, so I do not need to store permanent access keys in the application.

Next, I created a VPC Lattice service network and a service with an HTTPS listener. I registered the Lambda function in a target group and connected that target group to the listener.

I then configured the permissions on both sides. The EC2 role policy allows the application to invoke this particular Lattice service. The Lattice policies allow requests from that application role. I also enabled IAM authentication so that requests must carry a valid signature.

The important detail is that attaching an IAM role to EC2 does not automatically authenticate an HTTP request. The application still needs to sign the request.

I solved that by using Python to retrieve the role’s temporary credentials and sign the request with AWS Signature Version 4, usually called SigV4. VPC Lattice can then verify the signature, identify the caller, and evaluate the applicable permissions.

If those checks succeed, Lattice forwards the request to Lambda. A separate permission on the Lambda function allows Lattice to invoke it.

I tested the setup in two ways.

First, I sent a normal request without a signature. Lattice treated the caller as anonymous and returned HTTP 403, which means access was denied.

Then I sent a signed request using the permitted EC2 role. This time, I received HTTP 200. Lambda returned its message along with the caller’s role identity.

These results demonstrated that the setup rejects anonymous requests and accepts requests from the configured, authorized application.

The main advantage of this idea is simplicity. AWS manages the connectivity and request authentication, while IAM policies define access. This can reduce the infrastructure and maintenance needed compared with operating a separate mTLS and authorization system.

For small and medium-sized businesses using AWS, that can make secure service communication easier to implement and operate. The actual cost savings depend on traffic and the existing environment, but the lab demonstrates a working approach with relatively few components to manage.