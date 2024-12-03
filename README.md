# Udacity Project - Design for Performance and Scalability

This is one of the project in Udacity AWS Cloud Architect Nanodegree. Resources and instructions can be found [here](https://github.com/udacity/cd0345-design-for-performance-and-scalability).

## Project Overview

In this project, I have:
- Designed, provisioned, and monitored infrastructure in AWS using industry-standard and open source tools. 
- Practiced the skills I have learned throughout the course to optimize infrastructure for cost and performance. 
- Used Terraform to provision and configure AWS services in a global configuration.

![image](https://github.com/user-attachments/assets/e6b615f7-f9aa-4ebf-99f5-77fd58b3f426)


## Project Files
- `Exercise`: Contains the terraform code to create EC2 instances & deploy lamda function in AWS.
- `screenshots`: This folder contains all the screenshots taken at time of doing project.
- `Udacity_Diagram_1.pdf`: Contains a cost-effective AWS infrastructure architecture for a new social media application development project for 50,000 single-region users.
- `Udacity_Diagram_2.pdf`: Contains a SERVERLESS architecture schematic for a new application development project.
- `Initial_Cost_Estimate.csv`: Cost estimated using [AWS Pricing Calculator](https://calculator.aws/#/) for the architecture to run in AWS created in `Udacity_Diagram_1.pdf`.
    - Targeted a monthly estimate between $8,000-$10,000.
- `Reduced_Cost_Estimate.csv`: Cost estimated using [AWS Pricing Calculator](https://calculator.aws/#/) for the architecture to run in AWS created in `Udacity_Diagram_1.pdf`.
    - Targeted a monthly estimate to a maximum of $6,500.
- `Increased_Cost Estimate.csv`: Cost estimated using [AWS Pricing Calculator](https://calculator.aws/#/) for the architecture to run in AWS created in `Udacity_Diagram_1.pdf`.
    - Targeted a monthly estimate to a maximum of $20,000.

### How I reduced the estimate to $6,500

Below is the list of changes and reasons for the solution:

- `Change`: Change the back up storage type to `Magnetic HDD` (whose storage amount is set to `3000 GB`)
    - **Reason**: The reason is that we have 2 DB instances running with 90% utilizaiton and for a 50,000 region users, 3000 GB backup storage should suffice. 
    
### How I come up with an estimated cost of $20,000

Below is the list of changes and reasons for the solution:

- `Change`: Increased the number of in-use IPv4 Addresses. 
    - **Reason**: This will provide more IPv4 addresses for more EC2 instances, which supports high availability for the application. Even if `Northern Virginia` region is completely down, application will be up and running in `Ohio` region.
- `Change`: Increase the number of EC2 instances to 4 to increase the availabilty of the applications. Also include EBS storage amount for to increase the reliability and resiliency of the applications. 
    - **Reason**: This change ensure that the applications meet AWS' standard requirements for high availability, durability and resilency.
- `Change`: Add AWS Shield. 
    - **Reason**: As we use Elastic Load Blancers, AWS Cloud Front and public-facing applications with EC2 instnaces, having AWS Shield will help us protect the applications and their resources.
- `Change`: Add AWS WAF. 
    - **Reason**: Add an extra layer of protection on the public facing web application. This prevents common attacks like SQL Injection, XSS, Path Traversal, etc.
