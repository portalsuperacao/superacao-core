module AuthHelpers
  def jwt_authentication
    payload = {data: 'test',
               sub: 'fake-uid-id',
               iat: (Time.now.to_time.to_i - 10)}

     root_key = OpenSSL::PKey::RSA.new 2048 # the CA's public/private key
     root_ca = OpenSSL::X509::Certificate.new
     root_ca.version = 2 # cf. RFC 5280 - to make it a "v3" certificate
     root_ca.serial = 1
     root_ca.subject = OpenSSL::X509::Name.parse "/DC=org/DC=ruby-lang/CN=Ruby CA"
     root_ca.issuer = root_ca.subject # root CA's are "self-signed"
     root_ca.public_key = root_key.public_key
     root_ca.not_before = Time.now
     root_ca.not_after = root_ca.not_before + 2 * 365 * 24 * 60 * 60 # 2 years validity

     ef = OpenSSL::X509::ExtensionFactory.new
     ef.subject_certificate = root_ca
     ef.issuer_certificate = root_ca
     root_ca.add_extension(ef.create_extension("basicConstraints","CA:TRUE",true))
     root_ca.add_extension(ef.create_extension("keyUsage","keyCertSign, cRLSign", true))
     root_ca.add_extension(ef.create_extension("subjectKeyIdentifier","hash",false))
     root_ca.add_extension(ef.create_extension("authorityKeyIdentifier","keyid:always",false))
     root_ca.sign(root_key, OpenSSL::Digest::SHA256.new)

    @token = JWT.encode payload, root_key, 'RS256'

    stub_request(:get, /www.googleapis.com/).
          with(headers: {'Accept'=>'*/*'}).
          to_return(status: 200,
           body: { "foo": "#{root_ca.to_pem}" }.to_json,
           headers: {"Content-Type"=> "application/json"})

    @HTTP_AUTHORIZATION = "Bearer #{@token}"
  end
end
