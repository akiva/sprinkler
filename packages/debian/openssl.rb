package :openssl do
  description 'OpenSSL'
  apt 'openssl', sudo: true

  verify do
    has_apt 'openssl'
  end
end
