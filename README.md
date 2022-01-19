# README

This is a PAAS platform that has the goal of allowing a person that doesn't know kubernetes, docker etc. (mainly IT teachers) to create and manage applications that are created by students and deployed on kubernetes. The end goal would be for the teacher to manage thorugh GUI applications that utilise different frameworks, RDBMs, etc. through their entire lifecycle through GUI. The project utilizes terraform to manage the infrastacture state. 

# State of the project

The project has the minmal functionality to create any hcl (transformed to json) defined project inside a separated namespace for each user in a user group and later manage it's lifecycle. For example entirely through GUI a user can create a separate Postgres database for each student in a class and after the course is over swiftly delete them. I don't intend to continue further development of this project due to some difficulties related to utilizing school infrastructure on which the cluster is running. I certainly learned a lot about kubernetes, terraform and rails during the development of this project but as of now I see no point in continuing the development. I'd be glad to hand it over and provide sufficeint assistance along the way. Experience with Terraofrm, Kubernetes and Rails would be required to continue developemnt. 
