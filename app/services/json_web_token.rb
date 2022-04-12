class JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, ENV['SECRET'])
  end

  def self.decode(token)
    begin
      JWT.decode(token, ENV['SECRET'], true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end
end
