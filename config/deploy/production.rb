server '54.172.71.65', user: 'ubuntu', roles: %w{app db web}

role :app, %w{ubuntu@54.172.71.65}

set :ssh_options, {
  keys: ['private.pem'],
  forward_agent: true,
  auth_methods: ['publickey']
}
