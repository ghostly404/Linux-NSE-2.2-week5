ansible-playbook docker.yaml, wordpress.yaml -i hosts -l 10.1.0.8 -C
# Will give an error because Docker will not be installed on dry-run
