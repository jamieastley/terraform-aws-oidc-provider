TF_PLAN_NAME = tf_plan

plan:
	op run --env-file="aws.env" -- terraform plan -out=$(TF_PLAN_NAME)

apply_plan:
	op run --env-file="aws.env" -- terraform apply $(TF_PLAN_NAME)

destroy:
	op run --env-file="aws.env" -- terraform destroy