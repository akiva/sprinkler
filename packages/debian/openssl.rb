package :openssl do
  description 'OpenSSL'
  apt 'openssl'

  verify do
    has_apt 'openssl'
  end
end
