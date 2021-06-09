Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://172.21.188.53:3000"
    resource "*", headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
  end

  allow do
    origins "https://ability-accounting-react.vercel.app"
    resource "*", headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
  end
end